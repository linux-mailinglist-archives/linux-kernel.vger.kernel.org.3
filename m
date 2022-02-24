Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA584C231A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBXEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:42:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9446B0F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0E75CE1D78
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEE2C340E9;
        Thu, 24 Feb 2022 04:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645677711;
        bh=vuS0NmAC044ZKKLND1Y1u97qpqpWfUXe9v4dMoL9AQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XLhMhz9qF648RsZY748WuMLV3n2sP4IkVX6SQDXdIvpG1TMVIf/dBQkibiZPx/BVe
         Q4GwLQjWJbc2lXST2bz2POZfzdFKU1O9tGTh257Qu4ZjwAAcAe10S/ykFO3RIDnkm8
         dNwIPEAoBVZd0TR1OUq2vIUpk+9UiMqFt0vkD4SI=
Date:   Wed, 23 Feb 2022 20:41:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-Id: <20220223204150.5e90910fc40ff869666ad4c3@linux-foundation.org>
In-Reply-To: <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
        <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
        <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
        <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
        <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 13:53:56 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > gadget as it is a _one_ time early boot call. If there is a scenario
> > where this could be really abused then it should be mentioned
> > explicitly.
> 
> How about adding this note to the commit message?

I have already done that.  I added

"As Michal pointed out, this is unlikely to be exploitable because it is
__init code.  But the patch suppresses the warnings."

