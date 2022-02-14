Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4634B407B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiBNDuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:50:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBNDuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:50:10 -0500
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 19:50:03 PST
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6956212;
        Sun, 13 Feb 2022 19:50:03 -0800 (PST)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6C8E13FCCC;
        Mon, 14 Feb 2022 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644810027;
        bh=6JLxTZevHMlYVeby6Lh6UMpeElkbmngwOfI8fZ79xvs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vbNM+WcB0HwKMysA+G3Flz3Xwz9BisL3jgsF+SgUnRpMhPqpcy1L6cQEjdSIKiXb2
         bpmU7iCYAzm+H5DaTXTgbi4K2ql2nKoWeX8YcCEsctpwtW0COIvPdEPvkqFWxBMupb
         8j2VSnMdN4leF6TM/dpkGSmq8LlBUth3R9YPRdmd+pSlbR7zLQzwsut/+wgAdTz77j
         +TM9bK7Xs8Tb8m41ljhuihvpucpKV6U9gEg3ADBgWX/AhVww6UK2bn4VMwVQJ3t771
         HkQQk+PnG1e4HLzoOgf6TWrXi1zjsu7tzbU+qlqrluaj5P8BIELViE2RN4YIqO+zZe
         WeHJHsAjq9f0Q==
Message-ID: <f42b0010-3a7b-e781-5b7e-ac975c36c102@canonical.com>
Date:   Sun, 13 Feb 2022 19:40:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] apparmor: fix aa_label_asxprint return check
Content-Language: en-US
To:     trix@redhat.com, jmorris@namei.org, serge@hallyn.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220213213228.2806682-1-trix@redhat.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220213213228.2806682-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22 13:32, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> label.c:1802:3: warning: 2nd function call argument
>   is an uninitialized value
>   pr_info("%s", str);
>   ^~~~~~~~~~~~~~~~~~
> 
> str is set from a successful call to aa_label_asxprint(&str, ...)
> On failure a negative value is returned, not a -1.  So change
> the check.
> 
> Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: John Johansen <john.johansen@canonical.com>

thanks I have pulled this into my tree

> ---
>  security/apparmor/label.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 9eb9a9237926..a658b67c784c 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1744,7 +1744,7 @@ void aa_label_xaudit(struct audit_buffer *ab, struct aa_ns *ns,
>  	if (!use_label_hname(ns, label, flags) ||
>  	    display_mode(ns, label, flags)) {
>  		len  = aa_label_asxprint(&name, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}
> @@ -1772,7 +1772,7 @@ void aa_label_seq_xprint(struct seq_file *f, struct aa_ns *ns,
>  		int len;
>  
>  		len = aa_label_asxprint(&str, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}
> @@ -1795,7 +1795,7 @@ void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
>  		int len;
>  
>  		len = aa_label_asxprint(&str, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}

