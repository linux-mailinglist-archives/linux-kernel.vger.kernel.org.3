Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505452453C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbiELF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiELF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A088A24588
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652335047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0bDFb/tAAbguC+IHzTExFsJLrZiV0YVZh8GFZSOhC8=;
        b=fbQOa0cBLXisj8omCSSa4ehkiRuak1D7ivcAesdzCwyPCkjIpFVBDhbxqOg7VUuPmhAfZ6
        octWV/1UHItnQOxUgU1TekOyCt/8d7Z3wC0QJzE1nU3bHpD8HMhrqygk6yEYzM+JQIHF3Q
        Xv63KST+A4DJ34yey/QX7nFIrmTt+RM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-rHSAyJ5yNo-8U_8a8UXqrw-1; Thu, 12 May 2022 01:57:26 -0400
X-MC-Unique: rHSAyJ5yNo-8U_8a8UXqrw-1
Received: by mail-ej1-f69.google.com with SMTP id ga27-20020a1709070c1b00b006f43c161da4so2270624ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0bDFb/tAAbguC+IHzTExFsJLrZiV0YVZh8GFZSOhC8=;
        b=WgdkfyXmufa+iNqPt14gWCzk+Qi6HkDxZn97p0Tb0AWfxlIxbsEaQHUl2PESQ+txsc
         X/aLu4/FMRYQgnSDlWux4yz5eC2Pf2pz4bpYiN6BxcNaKv0UfBQXOSYOkqc/cxTUevpp
         QTR+eQ86nJmdbH1jWXGWurCW6+CeQZTNtB9L7vACUaJJVBrmk9JFhreKpdcocTd35B1q
         NWOAxwZvcSaECvS4vzNk74T8YN9MI16y6w9yCWOcouRp7qQTg6eKcsl/gHYObM9aV7Kw
         8ZfuFbk0FcKii7Epydd4gIriIM0iPEEeu0lul+KmIJn558B0lxGsq1qLU/MIRWpFXEzw
         wXww==
X-Gm-Message-State: AOAM531+rxyVmHUIHg7owoFeXbamXFBemR1dWVxQj9oBn90YK0wgODQa
        7cntrhPJB2TL3cwVtwdtsnbCAGB9jpk18za/KV2aCe2uTa/sNYeasQxtd6NkzojPBPOhJ2k1NUx
        Zo3hzZpiKzvbd0rvsw9qe2bCh
X-Received: by 2002:a05:6402:5188:b0:428:e77:b55b with SMTP id q8-20020a056402518800b004280e77b55bmr33524671edd.82.1652335044998;
        Wed, 11 May 2022 22:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweg8gy0e+6m0LjjDG+u4kpvwZO9qOgpH3UsJkCBifxEoBTksWtM9DNoFbA6rp3Rsn/gvanVw==
X-Received: by 2002:a05:6402:5188:b0:428:e77:b55b with SMTP id q8-20020a056402518800b004280e77b55bmr33524656edd.82.1652335044755;
        Wed, 11 May 2022 22:57:24 -0700 (PDT)
Received: from redhat.com ([2.55.42.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a170906608500b006f4512e7bc8sm1716477ejj.60.2022.05.11.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:57:24 -0700 (PDT)
Date:   Thu, 12 May 2022 01:57:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com
Subject: Re: [PATCH v1] vdpa: Warn if MTU configured is too low
Message-ID: <20220512014128-mutt-send-email-mst@kernel.org>
References: <20220511105642.124806-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511105642.124806-1-elic@nvidia.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:56:42PM +0300, Eli Cohen wrote:
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> 
> Print a warning if this recommendation is not met.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
>   chage pr_warn to netlink warning to userspace
> 
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..0fb4a615f267 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>  
> +/* Recommended virtio spec 1.1 section 5.1.4.1 */

I'd add name of section here too.

> +#define VIRTIO_MIN_PREFERRED_MTU 1280
> +

Preferred is kind of confusing here. I guess you are trying to
say it's not mandatory but I don't think this conveys this information.

Recommended (matching text below)?


>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct vdpa_dev_set_config config = {};
> @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  		err = PTR_ERR(mdev);
>  		goto err;
>  	}
> +	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> +	    (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> +	    config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> +		NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n");
>  	if ((config.mask & mdev->config_attr_mask) != config.mask) {
>  		NL_SET_ERR_MSG_MOD(info->extack,
>  				   "All provided attributes are not supported");


Pity we can't include the actual value here, but oh well. At least let's
include the recommended value, we can do that:
	"MTU is below recommended value of " __stringify(VIRTIO_MIN_PREFERRED_MTU) "\n"


> @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>  	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> -	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
>  };
>  
>  static const struct genl_ops vdpa_nl_ops[] = {
> -- 
> 2.35.1

