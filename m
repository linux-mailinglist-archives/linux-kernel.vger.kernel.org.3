Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614351034E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbiDZQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348348AbiDZQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:30:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6723169E44;
        Tue, 26 Apr 2022 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SlW7TrC7DpfmsqTmG1ehzyWxMybC0gyBrodqZVKNujo=; b=AL1nXEYrFs3sWPyCj/BCpaR8kl
        ORzLikysN23cOFeKWVaMfhCPhQwr0167C/Z6ZuzSInr+zIqYu5uM2bRMvPRBO/YBdL+HsWhpy+jjZ
        +i0yl6L3xA4KeC18M1HXRkMtLrDYfE0ny1w0aByZ2Ph/KKrcKfyuTc5cBpZm4cH0lKLIV1c/QjRRw
        TQD+Q4lq6VA90F7dxtWT3vET0VrXdSrhuKzYUUbTq52MUJBvQSRxCQY/FH3iRimn80NrDHKyBX4WP
        +QUWBMduVW8iDeVF0Dv277SfX+9PTSlOUMKgbwkEk0O5rAOTGYKJbuESATH/+sXmCZl8WfEWFQBnY
        2htSVmfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njO1g-00FLId-M1; Tue, 26 Apr 2022 16:26:56 +0000
Date:   Tue, 26 Apr 2022 09:26:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>, atomlin@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-modules@vger.kernel.org, linux-mediatek@lists.infradead.org,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] module: show disallowed symbol name for inherit_taint()
Message-ID: <YmgdUKmfym1/XnhP@bombadil.infradead.org>
References: <20220426042120.9686-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426042120.9686-1-lecopzer.chen@mediatek.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you base your changes on modules-next [0] and resend and Cc
atomlin@redhat.com?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis

On Tue, Apr 26, 2022 at 12:21:20PM +0800, Lecopzer Chen wrote:
> The error log for inherit_taint() doesn't really help to find the symbols
> which violate GPL rules.
> 
> For example,
> if a module has 50 disallowed symbols, the log only shows the content below
> and is duplicated with 50 lines.
>     AAA: module using GPL-only symbols uses symbols from proprietary module BBB.
>     AAA: module using GPL-only symbols uses symbols from proprietary module BBB.
>     ...
> 
> This patch add symbol name to tell the offending symbols explicitly.
> 
> To-be:
>     AAA: module using GPL-only symbols uses symbols SS1 from proprietary module BBB.
>     AAA: module using GPL-only symbols uses symbols SS2 from proprietary module BBB.
>     ...
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  kernel/module.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 6cea788fd965..30973f0d2b7c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1372,20 +1372,20 @@ static int verify_namespace_is_imported(const struct load_info *info,
>  	return 0;
>  }
>  
> -static bool inherit_taint(struct module *mod, struct module *owner)
> +static bool inherit_taint(struct module *mod, struct module *owner, const char *name)
>  {
>  	if (!owner || !test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints))
>  		return true;
>  
>  	if (mod->using_gplonly_symbols) {
> -		pr_err("%s: module using GPL-only symbols uses symbols from proprietary module %s.\n",
> -			mod->name, owner->name);
> +		pr_err("%s: module using GPL-only symbols uses symbols %s from proprietary module %s.\n",
> +			mod->name, name, owner->name);
>  		return false;
>  	}
>  
>  	if (!test_bit(TAINT_PROPRIETARY_MODULE, &mod->taints)) {
> -		pr_warn("%s: module uses symbols from proprietary module %s, inheriting taint.\n",
> -			mod->name, owner->name);
> +		pr_warn("%s: module uses symbols %s from proprietary module %s, inheriting taint.\n",
> +			mod->name, name, owner->name);
>  		set_bit(TAINT_PROPRIETARY_MODULE, &mod->taints);
>  	}
>  	return true;
> @@ -1417,7 +1417,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>  	if (fsa.license == GPL_ONLY)
>  		mod->using_gplonly_symbols = true;
>  
> -	if (!inherit_taint(mod, fsa.owner)) {
> +	if (!inherit_taint(mod, fsa.owner, name)) {
>  		fsa.sym = NULL;
>  		goto getname;
>  	}
> -- 
> 2.18.0
> 
