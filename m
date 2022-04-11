Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F524FB28F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbiDKENc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiDKENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:13:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65595FC0;
        Sun, 10 Apr 2022 21:11:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bb38so398093qtb.3;
        Sun, 10 Apr 2022 21:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3yJXVcrqLty6aGNcTEd6QMDwzRrVUyfdBhDs7kgX8Mw=;
        b=BeU8Ez+PKo94dBVWQCuTEh1HFkhznGznIZUgc/l/IfuW1rfr0BoBD4LvB8oOPu6rjD
         XTxD/H3NQ+YXzfdHdpr2pxybAhyAnJcQ+C87TxgBKohilVZ39jfkuVXXrFAJm4H6Eew1
         LyZZswmk3y9at90eO0paPczEDi24mKz8SHvuDT406pbxgydwPmLNn0dIPtmiVeLogmkX
         GHlpDjUs8DdB3Zn00s+GPJHiRk4UzALSeyk7dtF482c8643jEJTwErh4rBhvKrMvysC6
         obcj/96H+fhCcaOlHIPpRyV1YYFIOppsTF93TE8/RsAI0C+WvZ/wexkLm4NYgwPGmnMN
         rErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3yJXVcrqLty6aGNcTEd6QMDwzRrVUyfdBhDs7kgX8Mw=;
        b=wvCvJPUfjJqBopBpYP/qp4CvORx+n2l0QvPtEAM0F1f0+9Dk30s7m+pB0N/0q9y3tR
         JGIiTYqfZthO107gH02CSYBR17Yi5xJZbONcswA9vEScp6zn3KNqwrRuy9R5xwZBjoRA
         v3Zl6370/S2gxzCIDwaZu0otkGZ7qS8ISbgVLiJ4VYsWzPvMVDYb2W8EMcWWyve0P5iy
         rC1DaoGWNAExnmplZu1SxLRVwTx+1EzSI+vgk8KEdgXDgsuHDIPeeh7SQixenHmgpIIY
         zF0bauZd/CifyphnOeRzwkNOueVIOlAWYZQh7c58jqewN9Uf5ZREihUPSL72aKSK3M33
         NxLg==
X-Gm-Message-State: AOAM532+x1+15Yk4lKKrg9g14V5UbGSbBj410uuirqVZ/WtMyTiv14c+
        XnfFPuOjDjpZegx5u0KC5X0=
X-Google-Smtp-Source: ABdhPJy5zgje6WLnyqvFZqbwp0nWslpAfKWvtZmc3E5J52LkS11p7AHqOFnpv2h/WRHucv4XlIRDIA==
X-Received: by 2002:a05:622a:1b23:b0:2eb:db4b:7425 with SMTP id bb35-20020a05622a1b2300b002ebdb4b7425mr13992599qtb.563.1649650265855;
        Sun, 10 Apr 2022 21:11:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:91e2:dfcf:c904:aebc? ([2600:1700:2442:6db0:91e2:dfcf:c904:aebc])
        by smtp.gmail.com with ESMTPSA id l128-20020a37a286000000b0069c08952cddsm2997357qke.82.2022.04.10.21.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 21:11:05 -0700 (PDT)
Message-ID: <a8aa0c70-8915-00e1-5171-8b0a32fc6001@gmail.com>
Date:   Sun, 10 Apr 2022 23:11:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20220410210833.441504-1-frowand.list@gmail.com>
 <20220410210833.441504-3-frowand.list@gmail.com>
In-Reply-To: <20220410210833.441504-3-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding cc: Jan Kiszka <jan.kiszka@siemens.com>

On 4/10/22 16:08, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix various kfree() issues related to of_overlay_apply().
>   - Double kfree() of fdt and tree when init_overlay_changeset()
>     returns an error.
>   - free_overlay_changeset() free the root of the unflattened
>     overlay (variable tree) instead of the memory that contains
>     the unflattened overlay.
>   - For the case of a failure during applying an overlay, move kfree()
>     of new_fdt and overlay_mem into the function that allocated them.
>     For the case of removing an overlay, the kfree() remains in
>     free_overlay_changeset().
>   - Check return value of of_fdt_unflatten_tree() for error instead
>     of checking the returnded value of overlay_root.
> 
> More clearly document policy related to lifetime of pointers into
> overlay memory.
> 
> Double kfree()
> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Changes since v1:
>   - Move kfree()s from init_overlay_changeset() to of_overlay_fdt_apply()
>   - Better document lifetime of pointers into overlay, both in overlay.c
>     and Documentation/devicetree/overlay-notes.rst
> 
>  Documentation/devicetree/overlay-notes.rst |  23 +++-
>  drivers/of/overlay.c                       | 127 ++++++++++++---------
>  2 files changed, 91 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> index b2b8db765b8c..7a6e85f75567 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -119,10 +119,25 @@ Finally, if you need to remove all overlays in one-go, just call
>  of_overlay_remove_all() which will remove every single one in the correct
>  order.
>  
> -In addition, there is the option to register notifiers that get called on
> +There is the option to register notifiers that get called on
>  overlay operations. See of_overlay_notifier_register/unregister and
>  enum of_overlay_notify_action for details.
>  
> -Note that a notifier callback is not supposed to store pointers to a device
> -tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
> -respective node it received.
> +A notifier callback for OF_OVERLAY_PRE_APPLY, OF_OVERLAY_POST_APPLY, or
> +OF_OVERLAY_PRE_REMOVE may store pointers to a device tree node in the overlay
> +or its content but these pointers must not persist past the notifier callback
> +for OF_OVERLAY_POST_REMOVE.  The memory containing the overlay will be
> +kfree()ed after OF_OVERLAY_POST_REMOVE notifiers are called.  Note that the
> +memory will be kfree()ed even if the notifier for OF_OVERLAY_POST_REMOVE
> +returns an error.
> +
> +The changeset notifiers in drivers/of/dynamic.c are a second type of notifier
> +that could be triggered by applying or removing an overlay.  These notifiers
> +are not allowed to store pointers to a device tree node in the overlay
> +or its content.  The overlay code does not protect against such pointers
> +remaining active when the memory containing the overlay is freed as a result
> +of removing the overlay.
> +
> +Any other code that retains a pointer to the overlay nodes or data is
> +considered to be a bug because after removing the overlay the pointer
> +will refer to freed memory.
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index f74aa9ff67aa..c8e999518f2f 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -58,6 +58,7 @@ struct fragment {
>   * @id:			changeset identifier
>   * @ovcs_list:		list on which we are located
>   * @new_fdt:		Memory allocated to hold unflattened aligned FDT
> + * @overlay_mem:	the memory chunk that contains @overlay_tree
>   * @overlay_tree:	expanded device tree that contains the fragment nodes
>   * @count:		count of fragment structures
>   * @fragments:		fragment nodes in the overlay expanded device tree
> @@ -68,6 +69,7 @@ struct overlay_changeset {
>  	int id;
>  	struct list_head ovcs_list;
>  	const void *new_fdt;
> +	const void *overlay_mem;
>  	struct device_node *overlay_tree;
>  	int count;
>  	struct fragment *fragments;
> @@ -720,18 +722,20 @@ static struct device_node *find_target(struct device_node *info_node)
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>   * @ovcs:		Overlay changeset to build
>   * @new_fdt:		Memory allocated to hold unflattened aligned FDT
> + * @tree_mem:		Memory that contains @overlay_tree
>   * @overlay_tree:	Contains the overlay fragments and overlay fixup nodes
>   *
>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>   * the top level of @overlay_tree.  The relevant top level nodes are the
>   * fragment nodes and the __symbols__ node.  Any other top level node will
> - * be ignored.
> + * be ignored.  Populate other @ovcs fields.
>   *
>   * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
>   * detected in @overlay_tree, or -ENOSPC if idr_alloc() error.
>   */
>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
> -		const void *new_fdt, struct device_node *overlay_tree)
> +		const void *new_fdt, const void *tree_mem,
> +		struct device_node *overlay_tree)
>  {
>  	struct device_node *node, *overlay_node;
>  	struct fragment *fragment;
> @@ -751,9 +755,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	if (!of_node_is_root(overlay_tree))
>  		pr_debug("%s() overlay_tree is not root\n", __func__);
>  
> -	ovcs->overlay_tree = overlay_tree;
> -	ovcs->new_fdt = new_fdt;
> -
>  	INIT_LIST_HEAD(&ovcs->ovcs_list);
>  
>  	of_changeset_init(&ovcs->cset);
> @@ -832,6 +833,9 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  
>  	ovcs->id = id;
>  	ovcs->count = cnt;
> +	ovcs->new_fdt = new_fdt;
> +	ovcs->overlay_mem = tree_mem;
> +	ovcs->overlay_tree = overlay_tree;
>  	ovcs->fragments = fragments;
>  
>  	return 0;
> @@ -846,7 +850,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	return ret;
>  }
>  
> -static void free_overlay_changeset(struct overlay_changeset *ovcs)
> +static void free_overlay_changeset_contents(struct overlay_changeset *ovcs)
>  {
>  	int i;
>  
> @@ -861,12 +865,20 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  		of_node_put(ovcs->fragments[i].overlay);
>  	}
>  	kfree(ovcs->fragments);
> +}
> +static void free_overlay_changeset(struct overlay_changeset *ovcs)
> +{
> +
> +	free_overlay_changeset_contents(ovcs);
> +
>  	/*
> -	 * There should be no live pointers into ovcs->overlay_tree and
> +	 * There should be no live pointers into ovcs->overlay_mem and
>  	 * ovcs->new_fdt due to the policy that overlay notifiers are not
> -	 * allowed to retain pointers into the overlay devicetree.
> +	 * allowed to retain pointers into the overlay devicetree other
> +	 * than the window between OF_OVERLAY_PRE_APPLY overlay notifiers
> +	 * and the OF_OVERLAY_POST_REMOVE overlay notifiers.
>  	 */
> -	kfree(ovcs->overlay_tree);
> +	kfree(ovcs->overlay_mem);
>  	kfree(ovcs->new_fdt);
>  	kfree(ovcs);
>  }
> @@ -876,8 +888,10 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
>   * @new_fdt:		Memory allocated to hold the aligned FDT
> + * @tree_mem:		Memory that contains @overlay_tree
>   * @overlay_tree:	Expanded overlay device tree
>   * @ovcs_id:		Pointer to overlay changeset id
> + * @kfree_unsafe:	Pointer to flag to not kfree() @new_fdt and @overlay_tree
>   *
>   * Creates and applies an overlay changeset.
>   *
> @@ -910,34 +924,25 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * refused.
>   *
>   * Returns 0 on success, or a negative error number.  Overlay changeset
> - * id is returned to *ovcs_id.
> + * id is returned to *ovcs_id.  When references to @new_fdt and @overlay_tree
> + * may exist, *kfree_unsafe is set to true.
>   */
>  
> -static int of_overlay_apply(const void *new_fdt,
> -		struct device_node *overlay_tree, int *ovcs_id)
> +static int of_overlay_apply(const void *new_fdt, void *tree_mem,
> +		struct device_node *overlay_tree, int *ovcs_id,
> +		bool *kfree_unsafe)
>  {
>  	struct overlay_changeset *ovcs;
>  	int ret = 0, ret_revert, ret_tmp;
>  
> -	/*
> -	 * As of this point, new_fdt and overlay_tree belong to the overlay
> -	 * changeset.  overlay changeset code is responsible for freeing them.
> -	 */
> -
>  	if (devicetree_corrupt()) {
>  		pr_err("devicetree state suspect, refuse to apply overlay\n");
> -		kfree(new_fdt);
> -		kfree(overlay_tree);
> -		ret = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  
>  	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>  	if (!ovcs) {
> -		kfree(new_fdt);
> -		kfree(overlay_tree);
> -		ret = -ENOMEM;
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
>  	of_overlay_mutex_lock();
> @@ -945,28 +950,27 @@ static int of_overlay_apply(const void *new_fdt,
>  
>  	ret = of_resolve_phandles(overlay_tree);
>  	if (ret)
> -		goto err_free_overlay_tree;
> +		goto err_free_ovcs;
>  
> -	ret = init_overlay_changeset(ovcs, new_fdt, overlay_tree);
> +	ret = init_overlay_changeset(ovcs, new_fdt, tree_mem, overlay_tree);
>  	if (ret)
> -		goto err_free_overlay_tree;
> +		goto err_free_ovcs_contents;
>  
>  	/*
> -	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
> -	 * leaked to drivers, so can not kfree() overlay_tree,
> -	 * aka ovcs->overlay_tree; and can not free memory containing aligned
> -	 * fdt.  The aligned fdt is contained within the memory at
> -	 * ovcs->new_fdt, possibly at an offset from ovcs->new_fdt.
> +	 * After overlay_notify(), ovcs->overlay_tree related pointers may have
> +	 * leaked to drivers, so can not kfree() ovcs->overlay_mem and
> +	 * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
>  	 */
> +	*kfree_unsafe = true;
>  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>  	if (ret) {
>  		pr_err("overlay changeset pre-apply notify error %d\n", ret);
> -		goto err_free_overlay_changeset;
> +		goto err_free_ovcs_contents;
>  	}
>  
>  	ret = build_changeset(ovcs);
>  	if (ret)
> -		goto err_free_overlay_changeset;
> +		goto err_free_ovcs_contents;
>  
>  	ret_revert = 0;
>  	ret = __of_changeset_apply_entries(&ovcs->cset, &ret_revert);
> @@ -976,7 +980,7 @@ static int of_overlay_apply(const void *new_fdt,
>  				 ret_revert);
>  			devicetree_state_flags |= DTSF_APPLY_FAIL;
>  		}
> -		goto err_free_overlay_changeset;
> +		goto err_free_ovcs_contents;
>  	}
>  
>  	ret = __of_changeset_apply_notify(&ovcs->cset);
> @@ -997,18 +1001,16 @@ static int of_overlay_apply(const void *new_fdt,
>  
>  	goto out_unlock;
>  
> -err_free_overlay_tree:
> -	kfree(new_fdt);
> -	kfree(overlay_tree);
> +err_free_ovcs_contents:
> +	free_overlay_changeset_contents(ovcs);
>  
> -err_free_overlay_changeset:
> -	free_overlay_changeset(ovcs);
> +err_free_ovcs:
> +	kfree(ovcs);
>  
>  out_unlock:
>  	mutex_unlock(&of_mutex);
>  	of_overlay_mutex_unlock();
>  
> -out:
>  	pr_debug("%s() err=%d\n", __func__, ret);
>  
>  	return ret;
> @@ -1019,11 +1021,14 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  {
>  	void *new_fdt;
>  	void *new_fdt_align;
> +	void *overlay_mem;
> +	bool kfree_unsafe;
>  	int ret;
>  	u32 size;
>  	struct device_node *overlay_root = NULL;
>  
>  	*ovcs_id = 0;
> +	kfree_unsafe = false;
>  
>  	if (overlay_fdt_size < sizeof(struct fdt_header) ||
>  	    fdt_check_header(overlay_fdt)) {
> @@ -1046,30 +1051,37 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
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
> -	if (ret < 0) {
> -		/*
> -		 * new_fdt and overlay_root now belong to the overlay
> -		 * changeset.
> -		 * overlay changeset code is responsible for freeing them.
> -		 */
> -		goto out;
> -	}
> +	ret = of_overlay_apply(new_fdt, overlay_mem, overlay_root, ovcs_id,
> +			&kfree_unsafe);
> +	if (ret < 0)
> +		goto out_free_overlay_mem;
>  
> +	/*
> +	 * new_fdt and overlay_mem now belong to the overlay changeset.
> +	 * free_overlay_changeset() is responsible for freeing them.
> +	 */
>  	return 0;
>  
> +	/*
> +	 * After overlay_notify(), ovcs->overlay_tree related pointers may have
> +	 * leaked to drivers, so can not kfree() overlay_mem and new_fdt.  This
> +	 * will result in a memory leak.
> +	 */
> +out_free_overlay_mem:
> +	if (!kfree_unsafe)
> +		kfree(overlay_mem);
>  
>  out_free_new_fdt:
> -	kfree(new_fdt);
> +	if (!kfree_unsafe)
> +		kfree(new_fdt);
>  
> -out:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
> @@ -1237,6 +1249,11 @@ int of_overlay_remove(int *ovcs_id)
>  
>  	*ovcs_id = 0;
>  
> +	/*
> +	 * Note that the overlay memory will be kfree()ed by
> +	 * free_overlay_changeset() even if the notifier for
> +	 * OF_OVERLAY_POST_REMOVE returns an error.
> +	 */
>  	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
>  	if (ret_tmp) {
>  		pr_err("overlay changeset post-remove notify error %d\n",

