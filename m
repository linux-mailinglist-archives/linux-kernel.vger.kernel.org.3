Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397754EE43
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379196AbiFQAEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiFQAEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616362BFE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C4D7B82678
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD24C34114;
        Fri, 17 Jun 2022 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424238;
        bh=vcDV2pMUfx2RYW8UbJGnucRZpVwLFeJC08bYGA7L8SI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WkMmudRQMYzcNgSS1/kINcC1ofKsubM1KaNeg5+Tl63aiRuaTJJH2qS2s8isOlKpI
         HbH3/sBWlAu6RKQNBObG8AYZtdX9KoyIXkIK3aYSqn37ACpQ3+zendV/UZTZpsWf6A
         bwVb6lRZLNE4iXr67pqMdwbYWCASDUL4vKEHg91e1hUko85H8WtrrHAAIJhy+1vBLN
         Kr5ArnVs6aql0mHv4E5epmrhexPEWjMpI8APflgU92F0v9GHcmo7JBy4DdhTxbMWOJ
         g1y/Y/6/Svk3zZ2smA2a1MM1IuG7S+24XeHzFB4VWe2zTbX0B1ksIt/DfbOctGi86G
         HgUyqhU0IzJlg==
Date:   Thu, 16 Jun 2022 17:03:56 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Juergen Gross <jgross@suse.com>, hch@infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
In-Reply-To: <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206161657440.10483@ubuntu-linux-20-04-desktop>
References: <20220616053715.3166-1-jgross@suse.com> <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com> <cf755bb8-4265-875f-dc20-eefc0e8740f4@suse.com> <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-246346228-1655424238=:10483"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-246346228-1655424238=:10483
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Jun 2022, Oleksandr wrote:
> On 16.06.22 11:56, Juergen Gross wrote:
> > On 16.06.22 09:31, Oleksandr wrote:
> > > 
> > > On 16.06.22 08:37, Juergen Gross wrote:
> > > 
> > > 
> > > Hello Juergen
> > > 
> > > > Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> > > > Xen grant mappings") introduced a new requirement for using virtio
> > > > devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
> > > > feature.
> > > > 
> > > > This is an undue requirement for non-PV guests, as those can be operated
> > > > with existing backends without any problem, as long as those backends
> > > > are running in dom0.
> > > > 
> > > > Per default allow virtio devices without grant support for non-PV
> > > > guests.
> > > > 
> > > > Add a new config item to always force use of grants for virtio.
> > > > 
> > > > Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> > > > Xen grant mappings")
> > > > Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > ---
> > > > V2:
> > > > - remove command line parameter (Christoph Hellwig)
> > > > ---
> > > >   drivers/xen/Kconfig | 9 +++++++++
> > > >   include/xen/xen.h   | 2 +-
> > > >   2 files changed, 10 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > > index bfd5f4f706bc..a65bd92121a5 100644
> > > > --- a/drivers/xen/Kconfig
> > > > +++ b/drivers/xen/Kconfig
> > > > @@ -355,4 +355,13 @@ config XEN_VIRTIO
> > > >         If in doubt, say n.
> > > > +config XEN_VIRTIO_FORCE_GRANT
> > > > +    bool "Require Xen virtio support to use grants"
> > > > +    depends on XEN_VIRTIO
> > > > +    help
> > > > +      Require virtio for Xen guests to use grant mappings.
> > > > +      This will avoid the need to give the backend the right to map all
> > > > +      of the guest memory. This will need support on the backend side
> > > > +      (e.g. qemu or kernel, depending on the virtio device types used).
> > > > +
> > > >   endmenu
> > > > diff --git a/include/xen/xen.h b/include/xen/xen.h
> > > > index 0780a81e140d..4d4188f20337 100644
> > > > --- a/include/xen/xen.h
> > > > +++ b/include/xen/xen.h
> > > > @@ -56,7 +56,7 @@ extern u64 xen_saved_max_mem_size;
> > > >   static inline void xen_set_restricted_virtio_memory_access(void)
> > > >   {
> > > > -    if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> > > > +    if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
> > > >           platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > > 
> > > 
> > > Looks like, the flag will be *always* set for paravirtualized guests even
> > > if CONFIG_XEN_VIRTIO disabled.
> > > 
> > > Maybe we should clarify the check?
> > > 
> > > 
> > > if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) ||
> > > IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_pv_domain())
> > > 
> > >      platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > > 
> > 
> > Yes, we should. I had the function in grant-dma-ops.c in V1, and could drop
> > the
> > CONFIG_XEN_VIRTIO dependency for that reason.
> > 
> > I'll wait for more comments before sending V3, though.
> 
> ok
> 
> 
> 
> Please note, I am happy with current patch and it works in my Arm64 based
> environment.
> 
> Just one moment to consider.
> 
> 
> As it was already mentioned earlier in current thread the
> PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS (former
> arch_has_restricted_virtio_memory_access()) is not per device but about the
> whole guest. Being set it makes VIRTIO_F_ACCESS_PLATFORM and
> VIRTIO_F_VERSION_1 features mandatory for *all* virtio devices in the guest.
> 
> The question is “Do we want/need to lift this restriction for some devices
> (which backends are trusted so can access all guest memory) at the same time”?
> Copy here the original Viresh's question for the convenience:
> 
> "I understand from your email that the backends need to offer the
> VIRTIO_F_ACCESS_PLATFORM flag now, but should this requirement be a bit soft?
> I mean shouldn't we allow both types of backends to run with the same kernel,
> ones that offer this feature and others that don't? The ones that don't offer
> the feature, should continue to work like they used to, i.e. without the
> restricted memory access feature."
> 
> Technically this can be possible with HVM.
> 
> Let's imagine the following situation:
> 
> - Dom0 with backends which don't offer required features for some reason(s)
> 
> But running in Dom0 (trusted domain) these backends are not obliged to offer
> it (yes they can offer the required features and support grant mappings for
> the virtio, but this is not strictly necessary, as they are considered as
> trusted so are allowed to access all guest memory).
> 
> - DomD with backend which do offer them and require grant mappings for the
> virtio
> 
> If this is a valid and correct use-case, then we indeed need an ability to
> control that per device, otherwise - what is written below doesn't really
> matter.
> 
> I am wondering whether we can avoid using global
> PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS for Xen guests at all? I assume that all
> we need to do (when CONFIG_XEN_VIRTIO is enabled) is to make sure that *only*
> Xen grant DMA devices in HVM guests and *all* devices in PV guests offer
> required flags.
> 
> Below the diff how this could be done w/o an extra options (not completely
> tested), although I realize it might look hackish, and a lot more effort is
> needed to get it right. In my Arm64 based environment it works, I have tried
> to run two backends, the first offered required features and the corresponding
> device node had required property, but the second didn’t and there was no
> property.
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 1f9c3ba..07eb69f 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -443,8 +443,6 @@ static int __init xen_guest_init(void)
>         if (!xen_domain())
>                 return 0;
> 
> -       xen_set_restricted_virtio_memory_access();
> -
>         if (!acpi_disabled)
>                 xen_acpi_guest_init();
>         else
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 8b71b1d..517a9d8 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -195,8 +195,6 @@ static void __init xen_hvm_guest_init(void)
>         if (xen_pv_domain())
>                 return;
> 
> -       xen_set_restricted_virtio_memory_access();
> -
>         init_hvm_pv_info();
> 
>         reserve_shared_info();
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 30d24fe..ca85d14 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -108,8 +108,6 @@ static DEFINE_PER_CPU(struct tls_descs, shadow_tls_desc);
> 
>  static void __init xen_pv_init_platform(void)
>  {
> -       xen_set_restricted_virtio_memory_access();
> -
>         populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
> 
>         set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 371e16b..875690a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -167,6 +167,11 @@ void virtio_add_status(struct virtio_device *dev,
> unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> +int __weak device_has_restricted_virtio_memory_access(struct device *dev)
> +{
> +       return platform_has(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +}
> +
>  /* Do some validation, then set FEATURES_OK */
>  static int virtio_features_ok(struct virtio_device *dev)
>  {
> @@ -174,7 +179,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> 
>         might_sleep();
> 
> -       if (platform_has(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS)) {
> +       if (device_has_restricted_virtio_memory_access(dev->dev.parent)) {
>                 if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>                         dev_warn(&dev->dev,
>                                  "device must provide VIRTIO_F_VERSION_1\n");
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 6586152..da938f6 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/of.h>
>  #include <linux/pfn.h>
> +#include <linux/virtio_config.h>
>  #include <linux/xarray.h>
>  #include <xen/xen.h>
>  #include <xen/grant_table.h>
> @@ -286,6 +287,11 @@ bool xen_is_grant_dma_device(struct device *dev)
>         return has_iommu;
>  }
> 
> +int device_has_restricted_virtio_memory_access(struct device *dev)
> +{
> +       return (xen_pv_domain() || xen_is_grant_dma_device(dev));
> +}
> +
>  void xen_grant_setup_dma_ops(struct device *dev)
>  {
>         struct xen_grant_dma_data *data;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 7949829..b3a455b 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -559,4 +559,6 @@ static inline void virtio_cwrite64(struct virtio_device
> *vdev,
> _r;                                                     \
>         })
> 
> +int device_has_restricted_virtio_memory_access(struct device *dev);
> +
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0780a81..a99bab8 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,14 +52,6 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  extern u64 xen_saved_max_mem_size;
>  #endif
> 
> -#include <linux/platform-feature.h>
> -
> -static inline void xen_set_restricted_virtio_memory_access(void)
> -{
> -       if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> - platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> -}
> -
>  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
> (END)
> 
> 
> I think when x86 HVM gains required support (via ACPI or other means) to
> communicate the x86's alternative of "xen,grant-dma" then
> xen_is_grant_dma_device() will be just extended to handle that.

Yeah I like this approach:

- on ARM it bases the setting of PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS
  on "xen,grant-dma", as it should be
- it goes beyond my suggestion and it is capable of doing that
  per-device, which is awesome
- on x86, it always enables for PV guests as they have no other choice

On top of this we could add a command line option or kconfig option to
force-enable it as well for the benefit of x86/HVM, but I would make
that option x86 specific.
--8323329-246346228-1655424238=:10483--
