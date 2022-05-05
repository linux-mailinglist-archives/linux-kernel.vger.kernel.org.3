Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8099951C63A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiEERlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiEERlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:41:20 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD426139;
        Thu,  5 May 2022 10:37:40 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-ee1e7362caso797810fac.10;
        Thu, 05 May 2022 10:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kzvUm02uHeOo4u+aOxyhy+TmjqEXZS7/ZCIrYz39hmo=;
        b=PD1u5emRHEw2BaoNjxFjAA6Y7S1xTx9qcQ4M5BKsw6PIZq4n1EeUBO/urn8lp4HZj2
         udUzYq51J3dM6Za0J8p6hbEuYcJFSPfdKayoccl3FIGbWKy8LEgHXTHrPRgL23ZhEQS+
         71rVjwDVGVvibjWIAQ3gPqdrxO0uDt8JB9m/JhwaSL4FbCZu1UiBt3/9ytF6LBSb76iL
         xYqnPo84T3zRL73PnI2s9QdG01ILgNlsIuFK79G0xYFFRcJEsA1fl00R1wjZp7r4nuDj
         HBoXLq/EfoidcCJ9Y9y4E6pAWTfvECVEUucQkDhn9KVezdQzOjkkK8+u6uI2PxNwGLxp
         gXHw==
X-Gm-Message-State: AOAM533wJnLjQg6/CuJwxFSCcap0TFtMJhumexKQz98GZDkwkt5Pz6W9
        buhYOJAlGCRUZp2Cymp2pQ==
X-Google-Smtp-Source: ABdhPJwW3rIruHyT8havzQDmwnq59WGe42ycZEARvsTLzza5NVAWEFic6jYOBs656Y1KFDwI96fpZw==
X-Received: by 2002:a05:6870:471f:b0:ed:a180:77e8 with SMTP id b31-20020a056870471f00b000eda18077e8mr2673137oaq.19.1651772259931;
        Thu, 05 May 2022 10:37:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a4aa544000000b0035eb4e5a6c0sm996149oom.22.2022.05.05.10.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:37:39 -0700 (PDT)
Received: (nullmailer pid 4089077 invoked by uid 1000);
        Thu, 05 May 2022 17:37:38 -0000
Date:   Thu, 5 May 2022 12:37:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 1/3] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <YnQLYjcIc0PjvWYR@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
 <20220504154033.750511-2-clement.leger@bootlin.com>
 <9e470414-67a5-10ce-95eb-f8093fde70d4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e470414-67a5-10ce-95eb-f8093fde70d4@csgroup.eu>
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

On Thu, May 05, 2022 at 07:30:47AM +0000, Christophe Leroy wrote:
> 
> 
> Le 04/05/2022 à 17:40, Clément Léger a écrit :
> > Add function which allows to dynamically allocate and free properties.
> > Use this function internally for all code that used the same logic
> > (mainly __of_prop_dup()).
> > 
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > ---
> >   drivers/of/dynamic.c | 101 ++++++++++++++++++++++++++++++-------------
> >   include/linux/of.h   |  16 +++++++
> >   2 files changed, 88 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index cd3821a6444f..e8700e509d2e 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -313,9 +313,7 @@ static void property_list_free(struct property *prop_list)
> >   
> >   	for (prop = prop_list; prop != NULL; prop = next) {
> >   		next = prop->next;
> > -		kfree(prop->name);
> > -		kfree(prop->value);
> > -		kfree(prop);
> > +		of_property_free(prop);
> >   	}
> >   }
> >   
> > @@ -367,48 +365,95 @@ void of_node_release(struct kobject *kobj)
> >   }
> >   
> >   /**
> > - * __of_prop_dup - Copy a property dynamically.
> > - * @prop:	Property to copy
> > + * of_property_free - Free a property allocated dynamically.
> > + * @prop:	Property to be freed
> > + */
> > +void of_property_free(const struct property *prop)
> > +{
> > +	kfree(prop->value);
> > +	kfree(prop->name);
> > +	kfree(prop);
> > +}
> > +EXPORT_SYMBOL(of_property_free);
> > +
> > +/**
> > + * of_property_alloc - Allocate a property dynamically.
> > + * @name:	Name of the new property
> > + * @value:	Value that will be copied into the new property value
> > + * @value_len:	length of @value to be copied into the new property value
> > + * @len:	Length of new property value, must be greater than @value_len
> >    * @allocflags:	Allocation flags (typically pass GFP_KERNEL)
> >    *
> > - * Copy a property by dynamically allocating the memory of both the
> > + * Create a property by dynamically allocating the memory of both the
> >    * property structure and the property name & contents. The property's
> >    * flags have the OF_DYNAMIC bit set so that we can differentiate between
> >    * dynamically allocated properties and not.
> >    *
> >    * Return: The newly allocated property or NULL on out of memory error.
> >    */
> > -struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
> > +struct property *of_property_alloc(const char *name, const void *value,
> > +				   int value_len, int len, gfp_t allocflags)
> >   {
> > -	struct property *new;
> > +	int alloc_len = len;
> > +	struct property *prop;
> > +
> > +	if (len < value_len)
> > +		return NULL;
> >   
> > -	new = kzalloc(sizeof(*new), allocflags);
> > -	if (!new)
> > +	prop = kzalloc(sizeof(*prop), allocflags);
> > +	if (!prop)
> >   		return NULL;
> >   
> > +	prop->name = kstrdup(name, allocflags);
> > +	if (!prop->name)
> > +		goto out_err;
> > +
> >   	/*
> > -	 * NOTE: There is no check for zero length value.
> > -	 * In case of a boolean property, this will allocate a value
> > -	 * of zero bytes. We do this to work around the use
> > -	 * of of_get_property() calls on boolean values.
> > +	 * Even if the property has no value, it must be set to a
> > +	 * non-null value since of_get_property() is used to check
> > +	 * some values that might or not have a values (ranges for
> > +	 * instance). Moreover, when the node is released, prop->value
> > +	 * is kfreed so the memory must come from kmalloc.
> >   	 */
> > -	new->name = kstrdup(prop->name, allocflags);
> > -	new->value = kmemdup(prop->value, prop->length, allocflags);
> > -	new->length = prop->length;
> > -	if (!new->name || !new->value)
> > -		goto err_free;
> > +	if (!alloc_len)
> > +		alloc_len = 1;
> >   
> > -	/* mark the property as dynamic */
> > -	of_property_set_flag(new, OF_DYNAMIC);
> > +	prop->value = kzalloc(alloc_len, allocflags);
> > +	if (!prop->value)
> > +		goto out_err;
> >   
> > -	return new;
> > +	if (value)
> > +		memcpy(prop->value, value, value_len);
> 
> Could you use kmemdup() instead of kzalloc+memcpy ?

I'd prefer there be 1 alloc for struct property and value instead of 2. 
And maybe 'name' gets rolled into it too, but that gets a bit more 
complicated to manage I think. 

With memcpy, note this series[1].

Rob

[1] https://lore.kernel.org/all/20220504014440.3697851-30-keescook@chromium.org/
