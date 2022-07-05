Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C99566FFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiGENy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGENxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:53:49 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1E255AE;
        Tue,  5 Jul 2022 06:31:59 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 437BE1E39;
        Tue,  5 Jul 2022 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657027857;
        bh=RMLhdU6IsVMB09XaaxUlMWpKzqTB+hHFZ3H+6tDjqjg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=O8OFgAFzhJciwlfC3gkOD2TURzy76U6lldNh7yif1tkfct2AdkYQkwxoa8Gl0DkAC
         JoETJe2RAXa03OkaDR7KkdhMhK6r89qz2A2vB4gzHIgoKxxcWo84kNbOff8o7FdZ62
         yNbcWF6YBCyjuIdoWTPWKGeDiJaSrYjBZZveHNLk=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id EBE032118;
        Tue,  5 Jul 2022 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657027917;
        bh=RMLhdU6IsVMB09XaaxUlMWpKzqTB+hHFZ3H+6tDjqjg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Wwr/xxVFwVr+ct8VQ726hltGXDkoi3iq+PMdsps9/Er3CZ/R9WnGyu5Ywphlku41z
         x+PIzg5Q/WGiIoM6sXjeaKkWYkEXeo99U9BE3BknWCGo7apHRrcgzBK/IBfhqzq2Z+
         6i9T1hWzkCBJa/YxwVGHNlW48lBdZttmoWRpGYP0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 5 Jul 2022 16:31:57 +0300
Message-ID: <5ece0504-43ae-84f2-cfcf-ad12520bc195@paragon-software.com>
Date:   Tue, 5 Jul 2022 16:31:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] fs/ntfs3: remove duplicated assignment to variable
 r
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, <ntfs3@lists.linux.dev>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220704185319.592631-1-colin.i.king@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220704185319.592631-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 21:53, Colin Ian King wrote:
> The assignment to variable r is duplicated, the second assignment
> is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   fs/ntfs3/run.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
> index 7609d45a2d72..aba8ab1b9fcb 100644
> --- a/fs/ntfs3/run.c
> +++ b/fs/ntfs3/run.c
> @@ -563,7 +563,6 @@ bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
>   	e = run->runs + run->count;
>   	r = run->runs + index;
>   
> -	r = run->runs + index;
>   	if (vcn > r->vcn)
>   		r += 1;
>   

Thanks for patch, applied!
