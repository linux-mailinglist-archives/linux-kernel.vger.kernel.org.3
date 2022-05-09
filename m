Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCA52060D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiEIUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEIUlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58928E18;
        Mon,  9 May 2022 13:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA99616E9;
        Mon,  9 May 2022 20:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850CC385BA;
        Mon,  9 May 2022 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652128631;
        bh=hfhwSRPKpmCQiR4AWXJNzlQccUhXLt9YToKJxxPPASY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFdOx9HeBIeyMBt5gSS7grymNkPUHSE1YVzDiOtXmus2HnnAqp0sGx44436ka/JjK
         I387rYUkxfMdDytacNXNhNdyw+gRMYaPO67M9P9Z6/vigTdb2jxJmfzSiXwR77Bhgy
         +L/OYMTfHq9q458tv+6koQytNRPpUGZq19BguAzdlXoagqOvYcnL7Fla6MPijxt9eC
         74f/Jx8LoOAB7BVEQRG0k+qA8lVeGiwz0ZcGE8zruPKwZk1QPHxG8MNWZKjQKDEjT3
         kGcFBVuutnd3h1pO/0qTZJZdxFiaQ1OEXnhL9cTUCqjRobkRB5vgpTeMwXJJjf37nh
         7fIWs6dOzU3hg==
Date:   Mon, 9 May 2022 13:37:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiaoming Zhou <xzhou@marvell.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Message-ID: <Ynl7dXm38FaX/2od@sol.localdomain>
References: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 12:01:21AM +0000, Xiaoming Zhou wrote:
> Hi Keith,
> For the polynomial you used in this path is 0x9A6C9329AC4BC9B5ULL,  why it is
> different than the 0xAD93D23594C93659ULL defined in NVMe command set spec
> 5.2.1.3.4 ? Though the crc66 implemented in this patch can pass with test
> cases defined in Figure 121: 64b CRC Test Cases for 4KiB Logical Block with no
> Metadata.  Could you explain the discrepancy between the spec and the patch? 
> 

0x9A6C9329AC4BC9B5 is 0xAD93D23594C93659 with its bits reversed.

0xAD93D23594C93659 maps the polynomial coefficients to bits in the natural way.
However, writing the polynomial in this way isn't useful for this CRC variant,
as it is a bit-reversed CRC.

- Eric
