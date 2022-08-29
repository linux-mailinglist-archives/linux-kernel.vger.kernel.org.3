Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87845A408F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiH2BM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2BMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D4220FA;
        Sun, 28 Aug 2022 18:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D7160EC3;
        Mon, 29 Aug 2022 01:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D01C433D6;
        Mon, 29 Aug 2022 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661735574;
        bh=zFqjuwqIWouk+2CU9A+4UkGZ/bu8uW65TiM98RFbFJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LziecWemS/NQiruZfoaLBNXhnZ+rRBS9CwwJQnwFEyZYACssk0C6duY8jgQZDkVmI
         afIF1VqOrCyYf4uqB1dgqw/+V9c1wkrfnruMVYOcF9swSlRIK5eFKlWn9nhO5tpojt
         D4NIOtzc40MBVpPBNhv5/lY8r6w9rzMZFOZcA+D9o6rupnontXZiscq3M6fmP34x1A
         Oy9Zns4uw+/1B62ODqKWiVrHP91lnWqUk6i52w+5X8oZdEkJHNt98MsoenvT5mkUse
         DzTfjwS9EcDxwnhdq8JUsTZhAOX2tmZC89Nbo2Tf+s0SD2pstVgBm0qvvK+E7fHEEp
         c5igHTdQlxOrg==
Received: by mail-vk1-f182.google.com with SMTP id 134so3098110vkz.11;
        Sun, 28 Aug 2022 18:12:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo329AZnfuPeKyfeimDJsLIUKPrLjUoR6zqh6XKLcK778lXGdGqz
        M9PdhNPJ29zOFNhgUqsBMJf/KD7kKQ9sQXKDSQ==
X-Google-Smtp-Source: AA6agR5oS9oQQOdGApVtuYwt0XsdrLxayRvoV8H9X3o1gYde808KCwua7rcGgBSHbiJpO1EjXbMbseD1+AvGadM/wa4=
X-Received: by 2002:a05:6122:d86:b0:37d:3fe:df43 with SMTP id
 bc6-20020a0561220d8600b0037d03fedf43mr2496106vkb.15.1661735573306; Sun, 28
 Aug 2022 18:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220826220017.188066-1-marek.bykowski@gmail.com>
In-Reply-To: <20220826220017.188066-1-marek.bykowski@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 28 Aug 2022 20:12:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com>
Message-ID: <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Don't calculate initrd_start from the DT if
 'linux,initrd-end' is 0
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 5:00 PM Marek Bykowski <marek.bykowski@gmail.com> wrote:
>
> If the 'linux,initrd-end' property is 0 and 'linux,initrd-start' property
> is other than 0, then phys_initrd_size calculated from 'linux,initrd-end'
> - 'linux,initrd-start' is negative, that subsequently gets converted to
> a high positive value as being u64.
>
> For example if 'linux,initrd-start' is 8800_0000, 'linux,initrd-end' is 0,
> then the phys_initrd_size calculated is ffff_ffff_7800_0000 (= 0 -
> 8800_0000 = -8800_0000 + ULLONG_MAX + 1). On my system, FVP ARM64,
> the intird memory region with the (wrong) size is added to the bootmem and
> then attempted to being paged in paging_init() that results in the kernel
> oops as shown below.

Shouldn't we just check that start < end?

Can we check this somewhere not DT specific (and also not arch
specific)? Then we don't have to worry if any other method of setting
initrd could have the same error.

Rob
