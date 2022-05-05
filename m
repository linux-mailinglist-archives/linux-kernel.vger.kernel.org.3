Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593151C961
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385202AbiEETrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiEETrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:47:37 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35451591;
        Thu,  5 May 2022 12:43:56 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id l203so5429140oif.0;
        Thu, 05 May 2022 12:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VfBSloQQ81uRfQc02OmtDaGr9cu+x05nI2mcbylBCsg=;
        b=5AwJ+lTcV4c2Z34MRyeJxqBzTXFhI0lVNA45eXSjb5iUBNHlqpK01CKJSKl0q4WacN
         F78QR3SJcVoV/ZoRk0j+jeYRy8DRqq4mjEDXWPRpGu30XebXuDuqauTZhhI1s5he8WYM
         YIa9dtqk3cIXitzXy6+Ykx6ot+xySJdeBiLOwojGrc7QX8L5abz7qTCTyOrD86iVru5f
         /PdxibZfhBkGlJPm7+X6ruuQpjnYxW+ZDQNKD+fL7/v+6oNQ9ZskQxl35C7B76ppVEJu
         46PUPFZ76wQUABwuHOqwwX7msCQgOYw16WNiW0m4TznCa8b3yNwQ1G8Ti63uRC2rON+5
         APIw==
X-Gm-Message-State: AOAM533NOjvaURZR5Patmg7X4ZMHphbixlV5/8Dn6l46njomUmBCh+mV
        uZum6ty3xY1pTjcvAyJsQg==
X-Google-Smtp-Source: ABdhPJwSBr+UtFMHunpc0UdlmFG0dImEkNGB5BW+Slimw4MKA65OsBzcX/Cj15VVliXwLAu2w1ENDA==
X-Received: by 2002:a05:6808:120c:b0:325:731e:923 with SMTP id a12-20020a056808120c00b00325731e0923mr3220267oil.155.1651779835825;
        Thu, 05 May 2022 12:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a05683025cf00b0060603221278sm891396otu.72.2022.05.05.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:43:55 -0700 (PDT)
Received: (nullmailer pid 73673 invoked by uid 1000);
        Thu, 05 May 2022 19:43:54 -0000
Date:   Thu, 5 May 2022 14:43:54 -0500
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
Subject: Re: [PATCH 2/3] of: dynamic: add of_node_alloc() and of_node_free()
Message-ID: <YnQo+mdDBuoKA6Fq@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
 <20220504154033.750511-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220504154033.750511-3-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:40:32PM +0200, Clément Léger wrote:
> Add functions which allows to create and free nodes.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/of/dynamic.c | 59 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/of.h   |  9 +++++++
>  2 files changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index e8700e509d2e..ec28e5ba2969 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -455,6 +455,54 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
>  				 prop->length, allocflags);
>  }
>  
> +/**
> + * of_node_free - Free a node allocated dynamically.
> + * @node:	Node to be freed
> + */
> +void of_node_free(const struct device_node *node)
> +{
> +	kfree(node->full_name);
> +	kfree(node->data);
> +	kfree(node);
> +}
> +EXPORT_SYMBOL(of_node_free);

This shouldn't be needed. Nodes are refcounted, so any caller should 
just do a put.

Rob
