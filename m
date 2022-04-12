Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890094FE357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiDLODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356575AbiDLODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57313B3C1;
        Tue, 12 Apr 2022 07:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5321661B08;
        Tue, 12 Apr 2022 14:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C5DC385A5;
        Tue, 12 Apr 2022 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649772045;
        bh=7XwWmDU265ADzgFkMIUpXccN/Aq1zWWqFmfTNrTyE4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jvBSMjWSWF9ToHgNTLyaLDs4y7+pa9SC6fV05U3IrXbWk20n+3VYMyQGraoAhCLqL
         3jnXalRCqAlkk1u7KMBYsSCvaBtOsoSFLftu5g/lamh3nn74FLgNUK93qVQY34kB9H
         t7EcwWlVHgqnGfa9eaKEoQFcDDobC7H5Or2YwFGL7+RZCkjUVvNeUiQAKl4z2476z7
         x9/YUOPv4PgopDWXhz8/4c3LCs4QQ42+6op1x5YK5DX3YBxPH5NsZxlDgRwmPp2XHB
         u5+Y5pm6x7mgHD9kMO1564KzRqS22xW8gT0++SuSyVnCq2Pn40eDVfI5d9Jj3CQp8n
         WnCZ9/ygtRCzg==
Received: by mail-io1-f46.google.com with SMTP id x4so22366553iop.7;
        Tue, 12 Apr 2022 07:00:45 -0700 (PDT)
X-Gm-Message-State: AOAM533W6NskqswC3+Q9Y78QROtUMMuMZs4j5Syci7kCxBGd9fDWyajn
        iTeFOcBUpBVNW7u+GFp6SERFH22eI6h13tzoLw==
X-Google-Smtp-Source: ABdhPJxM5o0xNd49H1yoW5IgSN7s//zWfN0/pxJCopZJHwu14+nct/Ob/RCzYOHazqv/h3QB8/7BKDnQH9BqM3KE1dA=
X-Received: by 2002:a05:6602:27c5:b0:631:a30f:143a with SMTP id
 l5-20020a05660227c500b00631a30f143amr15686527ios.40.1649772044677; Tue, 12
 Apr 2022 07:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220410210833.441504-1-frowand.list@gmail.com> <20220410210833.441504-3-frowand.list@gmail.com>
In-Reply-To: <20220410210833.441504-3-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Apr 2022 09:00:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSerSHR_p-zPiEO_uzFrRF_=mOPtKFdGWD-OCt7WqLDQ@mail.gmail.com>
Message-ID: <CAL_JsqJSerSHR_p-zPiEO_uzFrRF_=mOPtKFdGWD-OCt7WqLDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: overlay: rework overlay apply and remove kfree()s
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  On Sun, Apr 10, 2022 at 4:08 PM <frowand.list@gmail.com> wrote:
>
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
>   * @id:                        changeset identifier
>   * @ovcs_list:         list on which we are located
>   * @new_fdt:           Memory allocated to hold unflattened aligned FDT
> + * @overlay_mem:       the memory chunk that contains @overlay_tree
>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>   * @count:             count of fragment structures
>   * @fragments:         fragment nodes in the overlay expanded device tree
> @@ -68,6 +69,7 @@ struct overlay_changeset {
>         int id;
>         struct list_head ovcs_list;
>         const void *new_fdt;
> +       const void *overlay_mem;
>         struct device_node *overlay_tree;
>         int count;
>         struct fragment *fragments;
> @@ -720,18 +722,20 @@ static struct device_node *find_target(struct device_node *info_node)
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>   * @ovcs:              Overlay changeset to build
>   * @new_fdt:           Memory allocated to hold unflattened aligned FDT
> + * @tree_mem:          Memory that contains @overlay_tree
>   * @overlay_tree:      Contains the overlay fragments and overlay fixup nodes
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
> -               const void *new_fdt, struct device_node *overlay_tree)
> +               const void *new_fdt, const void *tree_mem,
> +               struct device_node *overlay_tree)
>  {
>         struct device_node *node, *overlay_node;
>         struct fragment *fragment;
> @@ -751,9 +755,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>         if (!of_node_is_root(overlay_tree))
>                 pr_debug("%s() overlay_tree is not root\n", __func__);
>
> -       ovcs->overlay_tree = overlay_tree;
> -       ovcs->new_fdt = new_fdt;
> -
>         INIT_LIST_HEAD(&ovcs->ovcs_list);
>
>         of_changeset_init(&ovcs->cset);
> @@ -832,6 +833,9 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>
>         ovcs->id = id;
>         ovcs->count = cnt;
> +       ovcs->new_fdt = new_fdt;
> +       ovcs->overlay_mem = tree_mem;
> +       ovcs->overlay_tree = overlay_tree;
>         ovcs->fragments = fragments;
>
>         return 0;
> @@ -846,7 +850,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>         return ret;
>  }
>
> -static void free_overlay_changeset(struct overlay_changeset *ovcs)
> +static void free_overlay_changeset_contents(struct overlay_changeset *ovcs)
>  {
>         int i;
>
> @@ -861,12 +865,20 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>                 of_node_put(ovcs->fragments[i].overlay);
>         }
>         kfree(ovcs->fragments);
> +}
> +static void free_overlay_changeset(struct overlay_changeset *ovcs)
> +{
> +
> +       free_overlay_changeset_contents(ovcs);
> +
>         /*
> -        * There should be no live pointers into ovcs->overlay_tree and
> +        * There should be no live pointers into ovcs->overlay_mem and
>          * ovcs->new_fdt due to the policy that overlay notifiers are not
> -        * allowed to retain pointers into the overlay devicetree.
> +        * allowed to retain pointers into the overlay devicetree other
> +        * than the window between OF_OVERLAY_PRE_APPLY overlay notifiers
> +        * and the OF_OVERLAY_POST_REMOVE overlay notifiers.
>          */
> -       kfree(ovcs->overlay_tree);
> +       kfree(ovcs->overlay_mem);
>         kfree(ovcs->new_fdt);
>         kfree(ovcs);
>  }
> @@ -876,8 +888,10 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
>   * @new_fdt:           Memory allocated to hold the aligned FDT
> + * @tree_mem:          Memory that contains @overlay_tree
>   * @overlay_tree:      Expanded overlay device tree
>   * @ovcs_id:           Pointer to overlay changeset id
> + * @kfree_unsafe:      Pointer to flag to not kfree() @new_fdt and @overlay_tree

This screams hack.

It would be somewhat less hacky if we stored some state information in
ovcs struct that conveys the apply state of the overlay and then used
that to determine if we should do kfree or not.

Perhaps a better fix would be refcounting the overlay as a whole and
freeing everything when the refcount goes to 0.

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
> -               struct device_node *overlay_tree, int *ovcs_id)
> +static int of_overlay_apply(const void *new_fdt, void *tree_mem,
> +               struct device_node *overlay_tree, int *ovcs_id,
> +               bool *kfree_unsafe)
>  {
>         struct overlay_changeset *ovcs;
>         int ret = 0, ret_revert, ret_tmp;
>
> -       /*
> -        * As of this point, new_fdt and overlay_tree belong to the overlay
> -        * changeset.  overlay changeset code is responsible for freeing them.
> -        */
> -
>         if (devicetree_corrupt()) {
>                 pr_err("devicetree state suspect, refuse to apply overlay\n");
> -               kfree(new_fdt);
> -               kfree(overlay_tree);
> -               ret = -EBUSY;
> -               goto out;
> +               return -EBUSY;
>         }
>
>         ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>         if (!ovcs) {
> -               kfree(new_fdt);
> -               kfree(overlay_tree);
> -               ret = -ENOMEM;
> -               goto out;
> +               return -ENOMEM;
>         }
>
>         of_overlay_mutex_lock();
> @@ -945,28 +950,27 @@ static int of_overlay_apply(const void *new_fdt,
>
>         ret = of_resolve_phandles(overlay_tree);
>         if (ret)
> -               goto err_free_overlay_tree;
> +               goto err_free_ovcs;
>
> -       ret = init_overlay_changeset(ovcs, new_fdt, overlay_tree);
> +       ret = init_overlay_changeset(ovcs, new_fdt, tree_mem, overlay_tree);
>         if (ret)
> -               goto err_free_overlay_tree;
> +               goto err_free_ovcs_contents;
>
>         /*
> -        * after overlay_notify(), ovcs->overlay_tree related pointers may have
> -        * leaked to drivers, so can not kfree() overlay_tree,
> -        * aka ovcs->overlay_tree; and can not free memory containing aligned
> -        * fdt.  The aligned fdt is contained within the memory at
> -        * ovcs->new_fdt, possibly at an offset from ovcs->new_fdt.
> +        * After overlay_notify(), ovcs->overlay_tree related pointers may have
> +        * leaked to drivers, so can not kfree() ovcs->overlay_mem and
> +        * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
>          */
> +       *kfree_unsafe = true;
>         ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>         if (ret) {

If OF_OVERLAY_PRE_APPLY failed, I would think kfree would still be okay.

>                 pr_err("overlay changeset pre-apply notify error %d\n", ret);
> -               goto err_free_overlay_changeset;
> +               goto err_free_ovcs_contents;
>         }
