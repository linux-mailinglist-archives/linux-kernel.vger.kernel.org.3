Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8204FA580
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDIG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiDIG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:57:32 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 23:55:25 PDT
Received: from smtpo62.interia.pl (smtpo62.interia.pl [217.74.67.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADC23BF8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:55:24 -0700 (PDT)
Received: from t480s.localdomain (unknown [80.68.225.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Sat,  9 Apr 2022 08:52:41 +0200 (CEST)
Date:   Sat, 9 Apr 2022 08:52:39 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 1/1] of: overlay: of_overlay_apply() kfree() errors
Message-ID: <YlEtN6vk+XPRUkSX@t480s.localdomain>
References: <20220408172103.371637-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408172103.371637-1-frowand.list@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1649487162;
        bh=IrA88DSEzgkplkXRuVFdYiXXiL5inlvned7iHGSa1XY=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:X-Interia-Antivirus;
        b=RW7CJboh2v8UOakv3X1TjMnN7mrAMDGL5V7JbVFstUIIZhtcRTVJQGt5Vg2MJOYYP
         ygBMFZw7C8sm6K6XRC4Ud2VzUoMLxbW/2Tadm+yeAVVIQuBjiIjacnPhC//S0qG1oU
         sJhRLgwsMKi8EUgSRqIH2T+WGUUTwYBrMoYeUNJ4=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On kwi 08, 2022 12:21, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>

Hi Frank!

See my one comment below.

> Fix various kfree() issues related to of_overlay_apply().
>   - Double kfree() of fdt and tree when init_overlay_changeset()
>     returns an error.
>   - free_overlay_changeset() free of the root of the unflattened
>     overlay (variable tree) instead of the memory that contains
>     the unflattened overlay.
>   - Move similar kfree()s from multiple error locations to a
>     common error path (err_free_tree_unlocked:).
> 
> Double kfree()
> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 64 ++++++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index d80160cf34bb..1b9a90d61496 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -58,6 +58,7 @@ struct fragment {
>   * @id:			changeset identifier
>   * @ovcs_list:		list on which we are located
>   * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
> + * @overlay_mem:	the memory chunk that contains @overlay_tree
>   * @overlay_tree:	expanded device tree that contains the fragment nodes
>   * @count:		count of fragment structures
>   * @fragments:		fragment nodes in the overlay expanded device tree
> @@ -68,6 +69,7 @@ struct overlay_changeset {
>  	int id;
>  	struct list_head ovcs_list;
>  	const void *fdt;
> +	const void *overlay_mem;
>  	struct device_node *overlay_tree;
>  	int count;
>  	struct fragment *fragments;
> @@ -720,6 +722,7 @@ static struct device_node *find_target(struct device_node *info_node)
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>   * @ovcs:	Overlay changeset to build
>   * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
> + * @tree_mem:	Memory that contains @tree
>   * @tree:	Contains the overlay fragments and overlay fixup nodes
>   *
>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
> @@ -730,13 +733,23 @@ static struct device_node *find_target(struct device_node *info_node)
>   * detected in @tree, or -ENOSPC if idr_alloc() error.
>   */
>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
> -		const void *fdt, struct device_node *tree)
> +		const void *fdt, const void *tree_mem, struct device_node *tree)
>  {
>  	struct device_node *node, *overlay_node;
>  	struct fragment *fragment;
>  	struct fragment *fragments;
>  	int cnt, id, ret;
>  
> +	/*
> +	 * Must set these fields before any error return. fdt and tree_mem
> +	 * will be freed by free_overlay_changeset(), which is called if
> +	 * init_overlay_changeset() returns an error.
> +	 */
> +
> +	ovcs->fdt = fdt;
> +	ovcs->overlay_mem = tree_mem;
> +	ovcs->overlay_tree = tree;
> +
>  	/*
>  	 * Warn for some issues.  Can not return -EINVAL for these until
>  	 * of_unittest_apply_overlay() is fixed to pass these checks.
> @@ -750,9 +763,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	if (!of_node_is_root(tree))
>  		pr_debug("%s() tree is not root\n", __func__);
>  
> -	ovcs->overlay_tree = tree;
> -	ovcs->fdt = fdt;
> -
>  	INIT_LIST_HEAD(&ovcs->ovcs_list);
>  
>  	of_changeset_init(&ovcs->cset);
> @@ -865,7 +875,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
>  	 * to retain pointers into the overlay devicetree.
>  	 */
> -	kfree(ovcs->overlay_tree);
> +	kfree(ovcs->overlay_mem);
>  	kfree(ovcs->fdt);
>  	kfree(ovcs);
>  }
> @@ -875,6 +885,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
>   * @fdt:	base of memory allocated to hold the aligned FDT
> + * @tree_mem:	Memory that contains @tree
>   * @tree:	Expanded overlay device tree
>   * @ovcs_id:	Pointer to overlay changeset id
>   *
> @@ -913,31 +924,27 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * id is returned to *ovcs_id.
>   */
>  
> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -		int *ovcs_id)
> +static int of_overlay_apply(const void *fdt, void *tree_mem,
> +		struct device_node *tree, int *ovcs_id)
>  {
>  	struct overlay_changeset *ovcs;
>  	int ret = 0, ret_revert, ret_tmp;
>  
>  	/*
> -	 * As of this point, fdt and tree belong to the overlay changeset.
> +	 * As of this point, fdt and tree_mem belong to the overlay changeset.
>  	 * overlay changeset code is responsible for freeing them.
>  	 */
>  
>  	if (devicetree_corrupt()) {
>  		pr_err("devicetree state suspect, refuse to apply overlay\n");
> -		kfree(fdt);
> -		kfree(tree);
>  		ret = -EBUSY;
> -		goto out;
> +		goto err_free_tree_unlocked;
>  	}
>  
>  	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>  	if (!ovcs) {
> -		kfree(fdt);
> -		kfree(tree);
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_free_tree_unlocked;
>  	}
>  
>  	of_overlay_mutex_lock();
> @@ -947,9 +954,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  	if (ret)
>  		goto err_free_tree;
>  
> -	ret = init_overlay_changeset(ovcs, fdt, tree);
> +	/*
> +	 * init_overlay_changeset() promises to add tree_mem and tree to ovcs
> +	 * even in the case of an early error return, so they can be freed by
> +	 * free_overlay_changeset().
> +	 */
> +	ret = init_overlay_changeset(ovcs, fdt, tree_mem, tree);
>  	if (ret)
> -		goto err_free_tree;
> +		goto err_free_overlay_changeset;
>  
>  	/*
>  	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
> @@ -999,7 +1011,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  
>  err_free_tree:
>  	kfree(fdt);
> -	kfree(tree);
> +	kfree(tree_mem);
>  
>  err_free_overlay_changeset:
>  	free_overlay_changeset(ovcs);
> @@ -1008,9 +1020,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  	mutex_unlock(&of_mutex);
>  	of_overlay_mutex_unlock();
>  
> -out:
>  	pr_debug("%s() err=%d\n", __func__, ret);
>  
> +	return ret;
> +
> +err_free_tree_unlocked:
> +	kfree(fdt);
> +	kfree(tree_mem);
> +
>  	return ret;
>  }
>  
> @@ -1019,6 +1036,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  {
>  	void *new_fdt;
>  	void *new_fdt_align;
> +	void *overlay_mem;
>  	int ret;
>  	u32 size;
>  	struct device_node *overlay_root = NULL;
> @@ -1046,18 +1064,17 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
>  	memcpy(new_fdt_align, overlay_fdt, size);
>  
> -	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
> -	if (!overlay_root) {
> +	overlay_mem = of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
> +	if (!overlay_mem) {
>  		pr_err("unable to unflatten overlay_fdt\n");
>  		ret = -EINVAL;
>  		goto out_free_new_fdt;
>  	}
>  
> -	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
> +	ret = of_overlay_apply(new_fdt, overlay_mem, overlay_root, ovcs_id);
>  	if (ret < 0) {
>  		/*
> -		 * new_fdt and overlay_root now belong to the overlay
> -		 * changeset.
> +		 * new_fdt and overlay_mem now belong to the overlay changeset.
>  		 * overlay changeset code is responsible for freeing them.
>  		 */
>  		goto out;
> @@ -1067,6 +1084,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  
>  
>  out_free_new_fdt:
> +	kfree(overlay_mem);

There is no need to free this overlay_mem. You can end up here only when
overlay_mem is NULL.

>  	kfree(new_fdt);
>  
>  out:

-- 
Slawomir Stepien
