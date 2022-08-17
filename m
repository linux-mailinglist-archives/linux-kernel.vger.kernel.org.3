Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051FB5974DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiHQRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiHQRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:12:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97595FF59
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:12:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so18368723edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7Qt1OiwB1NvpNvFAmXsbXFbwMMwlOW1GJ6U3awjsLBM=;
        b=Ig5NGpyXAu/IiC7pCn5pEUlHynCDqQeLrI/1G6lRj478JvxU1k2wD3ooAop+hJfYmi
         OOI0+r3W9gc2AYDypHGRs4fNjfjkIlZ7pUFFbQlD9s9MzRWu95upt5/CxroPCYaXfJ58
         vZQ6AK+XEBahQKS63orPE2QpsqNHwgypllJCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7Qt1OiwB1NvpNvFAmXsbXFbwMMwlOW1GJ6U3awjsLBM=;
        b=ULrdqGL1XFzpBzFsZIb0zd6gPxRr37oeHJrunJEM9QY735XEnYdrblm2mhcc3xDHGl
         yjwe/j8w7y/UYN4J0yFhkVxxJvJsHx4CDsOI3vKrmIBF5PtrdLbX0BrRs7+n92AsnOgv
         dLZPEYJTN8678X/hNJYByJxnV2LnXYLC9lcJZHPo7PG8aN/YRUlUBouT3+JjqTO+9XCO
         gLS0qp/CNz0Dm+NIQhN3Sjn3es8q7keW0swZai4sZQm3pShHYmYhbE2wFcfgfcJFj8MH
         p6z1E9PXCQsMaM2ZWh7/7e9rQaQ9+o2FcYw6n+tFY5JEsAI4hZxbJEn/SrFTEGQ5rvoH
         ChRw==
X-Gm-Message-State: ACgBeo0It+7AEDEWzbSsod1tCOlPCChNdjfp84+c+qhrRa3C6Cl2q+62
        vhk3Ijso0ki+yM6mUhpzWZ5NTrXTqpSYc5+v/Dw=
X-Google-Smtp-Source: AA6agR401ll8BGgGbDHvP6FEvI+gxePboaakdjWuMfIbF4aryLV4aV+pS05p4cuCQoMx4hGb9DhZ1w==
X-Received: by 2002:a05:6402:278d:b0:43d:cf90:c91a with SMTP id b13-20020a056402278d00b0043dcf90c91amr24147247ede.186.1660756356140;
        Wed, 17 Aug 2022 10:12:36 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906319200b007304d084c5esm6824676ejy.166.2022.08.17.10.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:12:35 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id n7so5748823wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:12:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr14146052wri.442.1660756355255; Wed, 17
 Aug 2022 10:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220814212610.GA3690074@roeck-us.net>
In-Reply-To: <20220814212610.GA3690074@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Aug 2022 10:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsnBpMfUDgD=mxzEWhA6=ff3D3qssva0DFkE_55DXkLA@mail.gmail.com>
Message-ID: <CAHk-=wgsnBpMfUDgD=mxzEWhA6=ff3D3qssva0DFkE_55DXkLA@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Guenter Roeck <linux@roeck-us.net>,
        Andres Freund <andres@anarazel.de>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 2:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> syscaller reports lots of crashes with the mainline kernel. The latest
> I have seen, based on the current ToT, is attached. Backtraces are not
> always the same, but this one is typical.

Ok, I just pushed out the pull of the virtio fixes, so hopefully this
is all behind us.

Looking forward to (not really ;^) seeing what the google cloud
automation reports with this fixed.

Thanks,
                Linus
