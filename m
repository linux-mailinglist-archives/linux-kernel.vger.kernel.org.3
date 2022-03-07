Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF74D044A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiCGQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbiCGQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:41:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FD4EA37;
        Mon,  7 Mar 2022 08:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59B0BB81632;
        Mon,  7 Mar 2022 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC4DC340EF;
        Mon,  7 Mar 2022 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646671219;
        bh=D64AUoKStrCHhLRQnKnJTF+bBWtIrtXVo6ZGfwkuq/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxmZwu+bSl1W8wWDQsMLHRUtJuMN96MmoZOYEKFo3xeyvyXVp6qvoICHHDQ3EZNUR
         yLunK+eDuIEjtvnsphTmYTMu5y1EdEdBy9zUHBoQhNGNygNwXfkwAbWZjN+WwUUgYh
         8Ize1F35ehMGTWYIjKxeGbGV5dy42CILtK2ddyxP8eBS+Xlcg79EXRZPru1fpg8Lf3
         MXd8u+p0/2gvSQ71MwacksiyWDK8vHMwMbrmnkpGT8DgkyjWeWj4V6EAdbu092gsiE
         ikgTUzZCNcO5g7Uch/FfR9IyG5NLGESyiuuX/f4fMyxN3sgz281stU3GuSaacpah5r
         /g81vBEpXhxCQ==
Date:   Mon, 7 Mar 2022 18:39:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 21/32] selftests/sgx: Test two different SGX2 EAUG
 flows
Message-ID: <YiY1Slfy6CvwaTDy@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <32c1116934a588bd3e6c174684e3e36a05c0a4d4.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c1116934a588bd3e6c174684e3e36a05c0a4d4.1644274683.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:43PM -0800, Reinette Chatre wrote:
> +	addr = mmap((void *)self->encl.encl_base + total_size, PAGE_SIZE,
> +		    PROT_READ | PROT_WRITE | PROT_EXEC,
> +		    MAP_SHARED | MAP_FIXED, self->encl.fd, 0);

Maybe inline comment to just state that this is expected to work because
the range does not contain enclave pages, just as a reminder (had xref
to sgx_encl_may_map() to check this assumption). Otherwise, fine.

BR, Jarkko
