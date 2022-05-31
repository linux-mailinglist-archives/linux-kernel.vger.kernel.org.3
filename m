Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7895398FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiEaVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbiEaVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:49:16 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE0F8D6A1;
        Tue, 31 May 2022 14:49:16 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r65so168059oia.9;
        Tue, 31 May 2022 14:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YdK30offKzuTZgxr62+00M+QWbwt3uA7V7H9/gNhvY=;
        b=FsUL1Vv7kZLtXVKa9dVRNcYv5B3jPM11Hmz3v7vtfqNmol70ozYxJVmJGahhAMFYcq
         JsMxeR+VJqswbFctiR3XU1SA1szibeoC35fYPmZ7vZ1ovyx4BkKgygpknNJZ4fSSwZqv
         lXBxZq7VJmfHNm3Ftzzt4ilU0c715Z6SGAokKQjlxRaJQU19kssVd+/KrINxNqn5emyD
         3yjZvKgLiAgGGHVvQsKoZySWHTdUZwYxFpuBkDb7qT3VL9LsF7nzB7+UK4FZUxFZxq2J
         x+Miuxl5V+yqQn7KK5q+yIn5rj8hEhUx68Uy10ntYEI9X2fUq4ly7Ri8t9S/CBBtzQFb
         URmg==
X-Gm-Message-State: AOAM530iqiby1cs6MPRu4LMFz+jqYd0R4Nhtan5zKh39EEpkoeOhOLlp
        fDaj6TzMcqMg3xr40d5w/Q==
X-Google-Smtp-Source: ABdhPJwD6RXkPuAfYUMkWIfLQdr63/fiIfROvhb2rUyYgLwVv4ReaS7o65TXF0o2cMbd5Q2Pb3LLiA==
X-Received: by 2002:a05:6808:1315:b0:32c:3e3e:c2d7 with SMTP id y21-20020a056808131500b0032c3e3ec2d7mr4283979oiv.299.1654033755383;
        Tue, 31 May 2022 14:49:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek29-20020a056870f61d00b000f44c6041e1sm2048257oab.50.2022.05.31.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:49:15 -0700 (PDT)
Received: (nullmailer pid 2394769 invoked by uid 1000);
        Tue, 31 May 2022 21:49:14 -0000
Date:   Tue, 31 May 2022 16:49:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Qun-Wei Lin <qun-wei.lin@mediatek.com>, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, kuan-ying.lee@mediatek.com
Subject: Re: [PATCH] scripts: dtc: fix a false alarm for
 node_name_chars_strict
Message-ID: <20220531214914.GA2388344-robh@kernel.org>
References: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
 <8d4b8cc3-8433-24f9-1fc5-12d71e640952@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4b8cc3-8433-24f9-1fc5-12d71e640952@gmail.com>
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

On Tue, May 31, 2022 at 04:43:18PM -0400, Frank Rowand wrote:
> On 5/31/22 01:33, Qun-Wei Lin wrote:
> > The function check_node_name_chars_strict issues a false alarm when
> > compiling an overlay dts.
> > 
> > /fragment@0/__overlay__: Character '_' not recommended in node name
> > 
> > This workaround will fix it by skip checking for node named __overlay__.
> 
> This is not a false alarm.
> 
> Do not special case node name "__overlay__".  This node name should never
> occur in a modern overlay source file.

A dtbo -> dts pass will give warnings, so handling these nodes is 
worthwhile. Though thinking a bit more about it, I think this one is off 
by default, but W=2 turns it on.

Rob
