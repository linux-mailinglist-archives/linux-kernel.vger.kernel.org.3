Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7A55DE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiF0RTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiF0RTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:19:09 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578DF2649;
        Mon, 27 Jun 2022 10:19:08 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id l24so10216177ion.13;
        Mon, 27 Jun 2022 10:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZbXCZRn2tkLFwe+xZcXJJfs/8AzyxZ5b05h2ymqyzKo=;
        b=6KfjP90Sh81ontSfR7Aey3rmFwXlXG4J07XkNRDn2iNo/ygHNMKxUNlMv0L9xBkhqD
         ngpJOWe2/b6uuSc5DPps8HGE9r03abbZ3m8nE4DYBBUwBE+NeO+XYPzAbVd/yNUDwT1k
         xaT3K5BinimNnJCte8iG/LILSyW3RXsBg1wgrEGHE4qFeRIQg8FuZbWiNHsWp5B92CtI
         wJQUKyxCW1h5wEuP+fG8lCN5go4xzPd2NeTiIhW9SS93E2rX/l4dgqhKKrHzbPLGMro9
         BG2MZ+W1SSRnpuh11vmbncA5+zNpzHKoNPHZHzhTVoYWLv6RYN/AWFuoRVB6RxmUC+vg
         pCJw==
X-Gm-Message-State: AJIora/1LjnBiXFNLh3CW8iZIrO1euQlHILl7zazwdtZPBoMTCqBw8y4
        0lqefx+fu/Jzb7VWrOlnow==
X-Google-Smtp-Source: AGRyM1tu45zAsL+jIjvM+WaRtbHInJM639b0nwxc8mz53mtK5ZKqGi9kXi5EUH4/ZuQxDwX/kohBUQ==
X-Received: by 2002:a6b:7711:0:b0:674:fcb2:1256 with SMTP id n17-20020a6b7711000000b00674fcb21256mr7103853iom.32.1656350347617;
        Mon, 27 Jun 2022 10:19:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05663842cd00b0032ead96ee5csm4863972jab.165.2022.06.27.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:19:07 -0700 (PDT)
Received: (nullmailer pid 2614372 invoked by uid 1000);
        Mon, 27 Jun 2022 17:19:05 -0000
Date:   Mon, 27 Jun 2022 11:19:05 -0600
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
Subject: Re: [PATCH v3 1/5] of: constify of_property_check_flags() prop
 argument
Message-ID: <20220627171905.GA2612959-robh@kernel.org>
References: <20220620104123.341054-1-clement.leger@bootlin.com>
 <20220620104123.341054-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620104123.341054-2-clement.leger@bootlin.com>
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

On Mon, Jun 20, 2022 at 12:41:19PM +0200, Clément Léger wrote:
> This argument is not modified and thus can be set as const.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  include/linux/of.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I already applied this patch, don't resend it.

Rob
