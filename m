Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9070599D89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbiHSO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349572AbiHSO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C0EA33D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B883561199
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9743DC433D7;
        Fri, 19 Aug 2022 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660919211;
        bh=fGoMU6DeNob0TwcPIAynfHbsmVzBqJ5hRq1jSOsycFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6Rhf1KkurTHSjhs8FWrXeH5wwUHD2m0WpgLyFnA+oa40NHJjMGs7gW5k1bRfIYFU
         kwYJuy3nAic8r2egKQK/VF8+OZ6EfPQ3AxToka5JkLQY0/yWsPPFsbTDyBEyWcb4RY
         WXyRn+M/MkEyd6eSCqLeLxbWcWVVF5spNtNVGxtikm5Hb/9P4iQFJD2uuAZmDYs+bB
         Oz0W/M3AVOUXsZ0XzT1LXi4RaRpVmcFYwT8lQzT4QShLhP3xlPnnKo0TLST2cDoLDi
         CTNdlc3wt9N6NaviEOYkA/06Xw5haDPY4ARurQlRlKo9pavUuQgSCw63ed9/ftSHyH
         bteZjcXEn/R1w==
Date:   Fri, 19 Aug 2022 15:26:45 +0100
From:   Jean-Philippe Brucker <jpb@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        eric.auger@redhat.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH v2 8/9] iommu/of: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <Yv+dpeIPvde7oDHi@myrica>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-9-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601070707.3946847-9-saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Wed, Jun 01, 2022 at 12:07:04AM -0700, Saravana Kannan via iommu wrote:
> Now that fw_devlink=on and fw_devlink.strict=1 by default and fw_devlink
> supports iommu DT properties, the execution will never get to the point
> where driver_deferred_probe_check_state() is called before the supplier
> has probed successfully or before deferred probe timeout has expired.
> 
> So, delete the call and replace it with -ENODEV.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/iommu/of_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5696314ae69e..41f4eb005219 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -40,7 +40,7 @@ static int of_iommu_xlate(struct device *dev,
>  	 * a proper probe-ordering dependency mechanism in future.
>  	 */
>  	if (!ops)
> -		return driver_deferred_probe_check_state(dev);
> +		return -ENODEV;

Unfortunately this breaks virtio-iommu on v6.0-rc1. Could you add it to
your revert series [1]?

Eventually I'd really like to use fw_devlink in order to enable module
support, so I'm looking for a proper fix. Our DT description is peculiar
because the virtio-iommu, when it uses the virtio-pci transport, can
appear on the same PCI bus than the endpoints it manages. So the PCI node
looks like this:

	pcie@10000000 {
		compatible = "pci-host-ecam-generic";
		...
		iommu-map = <0x00 &viommu 0x00 0x20>
		            <0x21 &viommu 0x21 0xffdf>;

		viommu: virtio_iommu@32 {
			#iommu-cells = <0x01>;
			reg = <0x2000 0x00 0x00 0x00 0x00>;
			compatible = "virtio,pci-iommu";
		};
	};

The iommu-map property points to the IOMMU sub-node for all endpoints
except the IOMMU itself (device 0x20 - 00:04.0). fw_devlink currently
rejects this:

  [    0.270150] OF: Not linking pcie@10000000 to virtio_iommu@32 - is descendant
  [    0.270324] OF: Not linking pcie@10000000 to virtio_iommu@32 - is descendant

I don't know yet if this kind of topology could ever work with fw_devlink,
but I thought I'd notify you before digging further.

Thanks,
Jean

[1] https://lore.kernel.org/all/20220727185012.3255200-1-saravanak@google.com/#t

>  
>  	if (!try_module_get(ops->owner))
>  		return -ENODEV;
> -- 
> 2.36.1.255.ge46751e96f-goog
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
