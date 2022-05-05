Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3951C953
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385144AbiEETlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:41:02 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49995D653;
        Thu,  5 May 2022 12:37:17 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso5234707fac.1;
        Thu, 05 May 2022 12:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4FHNCssXLFqwQGqra/f/nh5V75COL/MDHO9EQPaBm3s=;
        b=L0Q1JGXoQdz+lOff7mSrG9GzdUt81Fv1+1WLovxAh6OVcFqji5s7E7Q2tpP+wSuINj
         GFUUfZ+zez5vMD0uLfiZkViySugfa5mbqEpmCozUZamEEtnHlZbD32pPw9eY5WPvhQNN
         9BfU5WRQxjoMedKIUWoB0XQo8vNbgeP1pTkZNHC3xlT+JZ9GMc3bFkmb3DUqlzBaHyBC
         Xd0ZkIKcsue9oPAeOb+xRIaU7WtqAs3ikSWfUZJt7E7BN90QhLUYgD5g5+wi5LSKHiTK
         iufVU+yB5cvZA7ZpaAyicTOd3Iwxguuelxt6QRb8pGrY0u4ENuMnQgDfN+d0+Cw+hZhq
         bz9A==
X-Gm-Message-State: AOAM532RJJFaBejHXMWiYunN7bXllIFxS/2ZR6EsZGA9jCSn/DbY0XSi
        Gffn7SBZlJnuJO3B/9ji2w==
X-Google-Smtp-Source: ABdhPJyZwSdFtHbBL/goDmwbHlh8lBm+f+57I5VNi5CvpyLTfwAeBWHqZtbRtN/3q0Sl8XicxhK63Q==
X-Received: by 2002:a05:6870:bac6:b0:ee:e97:bb65 with SMTP id js6-20020a056870bac600b000ee0e97bb65mr1732164oab.212.1651779437067;
        Thu, 05 May 2022 12:37:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0f26000000b006060322123esm917625ott.14.2022.05.05.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:37:16 -0700 (PDT)
Received: (nullmailer pid 63847 invoked by uid 1000);
        Thu, 05 May 2022 19:37:15 -0000
Date:   Thu, 5 May 2022 14:37:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <YnQnayouXw9/jp/E@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
 <20220504154033.750511-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220504154033.750511-2-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:40:31PM +0200, Clément Léger wrote:
> Add function which allows to dynamically allocate and free properties.
> Use this function internally for all code that used the same logic
> (mainly __of_prop_dup()).
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/of/dynamic.c | 101 ++++++++++++++++++++++++++++++-------------
>  include/linux/of.h   |  16 +++++++
>  2 files changed, 88 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..e8700e509d2e 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -313,9 +313,7 @@ static void property_list_free(struct property *prop_list)
>  
>  	for (prop = prop_list; prop != NULL; prop = next) {
>  		next = prop->next;
> -		kfree(prop->name);
> -		kfree(prop->value);
> -		kfree(prop);
> +		of_property_free(prop);
>  	}
>  }
>  
> @@ -367,48 +365,95 @@ void of_node_release(struct kobject *kobj)
>  }
>  
>  /**
> - * __of_prop_dup - Copy a property dynamically.
> - * @prop:	Property to copy
> + * of_property_free - Free a property allocated dynamically.
> + * @prop:	Property to be freed
> + */
> +void of_property_free(const struct property *prop)
> +{
> +	kfree(prop->value);
> +	kfree(prop->name);
> +	kfree(prop);
> +}
> +EXPORT_SYMBOL(of_property_free);
> +
> +/**
> + * of_property_alloc - Allocate a property dynamically.
> + * @name:	Name of the new property
> + * @value:	Value that will be copied into the new property value
> + * @value_len:	length of @value to be copied into the new property value
> + * @len:	Length of new property value, must be greater than @value_len

What's the usecase for the lengths being different? That doesn't seem 
like a common case, so perhaps handle it with a NULL value and 
non-zero length. Then the caller has to deal with populating 
prop->value.

>   * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
>   *
> - * Copy a property by dynamically allocating the memory of both the
> + * Create a property by dynamically allocating the memory of both the
>   * property structure and the property name & contents. The property's
>   * flags have the OF_DYNAMIC bit set so that we can differentiate between
>   * dynamically allocated properties and not.
>   *
>   * Return: The newly allocated property or NULL on out of memory error.
>   */
> -struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
> +struct property *of_property_alloc(const char *name, const void *value,
> +				   int value_len, int len, gfp_t allocflags)
>  {
> -	struct property *new;
> +	int alloc_len = len;
> +	struct property *prop;
> +
> +	if (len < value_len)
> +		return NULL;
>  
> -	new = kzalloc(sizeof(*new), allocflags);
> -	if (!new)
> +	prop = kzalloc(sizeof(*prop), allocflags);
> +	if (!prop)
>  		return NULL;
>  
> +	prop->name = kstrdup(name, allocflags);
> +	if (!prop->name)
> +		goto out_err;
> +
>  	/*
> -	 * NOTE: There is no check for zero length value.
> -	 * In case of a boolean property, this will allocate a value
> -	 * of zero bytes. We do this to work around the use
> -	 * of of_get_property() calls on boolean values.
> +	 * Even if the property has no value, it must be set to a
> +	 * non-null value since of_get_property() is used to check
> +	 * some values that might or not have a values (ranges for
> +	 * instance). Moreover, when the node is released, prop->value
> +	 * is kfreed so the memory must come from kmalloc.

Allowing for NULL value didn't turn out well...

We know that we can do the kfree because OF_DYNAMIC is set IIRC...

If we do 1 allocation for prop and value, then we can test 
for "prop->value == prop + 1" to determine if we need to free or not.

>  	 */
> -	new->name = kstrdup(prop->name, allocflags);
> -	new->value = kmemdup(prop->value, prop->length, allocflags);
> -	new->length = prop->length;
> -	if (!new->name || !new->value)
> -		goto err_free;
> +	if (!alloc_len)
> +		alloc_len = 1;
>  
> -	/* mark the property as dynamic */
> -	of_property_set_flag(new, OF_DYNAMIC);
> +	prop->value = kzalloc(alloc_len, allocflags);
> +	if (!prop->value)
> +		goto out_err;
>  
> -	return new;
> +	if (value)
> +		memcpy(prop->value, value, value_len);
> +
> +	prop->length = len;
> +	of_property_set_flag(prop, OF_DYNAMIC);
> +
> +	return prop;
> +
> +out_err:
> +	of_property_free(prop);
>  
> - err_free:
> -	kfree(new->name);
> -	kfree(new->value);
> -	kfree(new);
>  	return NULL;
>  }
> +EXPORT_SYMBOL(of_property_alloc);
> +
> +/**
> + * __of_prop_dup - Copy a property dynamically.
> + * @prop:	Property to copy
> + * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
> + *
> + * Copy a property by dynamically allocating the memory of both the
> + * property structure and the property name & contents. The property's
> + * flags have the OF_DYNAMIC bit set so that we can differentiate between
> + * dynamically allocated properties and not.
> + *
> + * Return: The newly allocated property or NULL on out of memory error.
> + */
> +struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
> +{
> +	return of_property_alloc(prop->name, prop->value, prop->length,
> +				 prop->length, allocflags);

This can now be a static inline.

> +}
>  
>  /**
>   * __of_node_dup() - Duplicate or create an empty device node dynamically.
> @@ -447,9 +492,7 @@ struct device_node *__of_node_dup(const struct device_node *np,
>  			if (!new_pp)
>  				goto err_prop;
>  			if (__of_add_property(node, new_pp)) {
> -				kfree(new_pp->name);
> -				kfree(new_pp->value);
> -				kfree(new_pp);
> +				of_property_free(new_pp);
>  				goto err_prop;
>  			}
>  		}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 04971e85fbc9..6b345eb71c19 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1463,6 +1463,11 @@ enum of_reconfig_change {
>  };
>  
>  #ifdef CONFIG_OF_DYNAMIC
> +extern struct property *of_property_alloc(const char *name, const void *value,
> +					  int value_len, int len,
> +					  gfp_t allocflags);
> +extern void of_property_free(const struct property *prop);
> +
>  extern int of_reconfig_notifier_register(struct notifier_block *);
>  extern int of_reconfig_notifier_unregister(struct notifier_block *);
>  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
> @@ -1507,6 +1512,17 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
>  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
>  }
>  #else /* CONFIG_OF_DYNAMIC */
> +
> +static inline struct property *of_property_alloc(const char *name,
> +						 const void *value,
> +						 int value_len, int len,
> +						 gfp_t allocflags)
> +{
> +	return NULL;
> +}
> +
> +static inline  void of_property_free(const struct property *prop) {}
> +
>  static inline int of_reconfig_notifier_register(struct notifier_block *nb)
>  {
>  	return -EINVAL;
> -- 
> 2.34.1
> 
> 
