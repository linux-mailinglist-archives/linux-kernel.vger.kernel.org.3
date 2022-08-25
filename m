Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83B5A17D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiHYRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiHYRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:17:53 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C869BC83F;
        Thu, 25 Aug 2022 10:17:49 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id h67so20586920vsc.11;
        Thu, 25 Aug 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8Yr88Z/taNpsbj093sVxvmE5u/Jj7tZR07/yhCU5Lqo=;
        b=XRxmMvpMtNwyy9EMeE2JoVqvro/aCwyM/ofFekkK/tgjSftErT7j7rrfUR0IbV8zor
         QNugT1Xrj0vvdDhfzvWWI0Sc2LQQ+LxpCy8+N+PG8Qx7b/yoZjuqsJL8Pi743Jrh1RCE
         kjXIaQFR0WujkbzYQF9OScqnIyMwtml/uEvKQ6db9/D5rfFyMctFjy0hHc/N95sdJNdg
         uvogdrvZsMWH5HdmyzPQstcfE9IWMuxYF1dJ0yIHTB5ghNKnIty0Lb4ccEwv2+Y8H6A0
         oHJ1PxeK3+rC/QbtSYiHO7Rymz6+94cKRVTMzhS0Z19tR7GA/7RxcnQRfsm/xManx4u0
         eQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8Yr88Z/taNpsbj093sVxvmE5u/Jj7tZR07/yhCU5Lqo=;
        b=E3ayRWq2fIoozHqRmMFY3UpeFGn0wiPKuAknDbQEkGLWu4yk1R6CjbvdHTN57ziylF
         avBFwayXDLELIWH/TKwu5wB/lRYbTozHEImGwCX6rP7UtpOPoqS1zkrAF77rn5s9QyBv
         pBUa8dq9z/zEmUDDrm6coN1Eppw3rblw+g7lbMPrUaUylZi83I5RHh6p+nd1x0xMRmHq
         V+XOfEGnndl5xeRPI23FPVGB67bx2RiJOmgj3VO1m6le9ST6uee9mNoyRndK8jKvuc8V
         0jBh5rAhiL1DN6Cu4bCy/NDSFFU+Os4rBag3y5dw4h4onaH5mWE44MqwKeEG+d3NEY5j
         UPsg==
X-Gm-Message-State: ACgBeo2gjjent+bR8UCXHApGrIR6a4E8NdO/Ci21RKBFX3BKVDIdVDws
        UYl0oIagVfWYAKyAvVC31QwGh4EE2Nl3QDZG5Hs=
X-Google-Smtp-Source: AA6agR6Kz8Wz0HOcwwaX94FqGjVGOW3FZ4ReV5Lesvg80SasBa3F66vvW9r7sieP+OV9YDCX2XUXwzbhvCtxtLPsmYU=
X-Received: by 2002:a67:8c6:0:b0:390:4ea0:994 with SMTP id 189-20020a6708c6000000b003904ea00994mr2063445vsi.79.1661447868312;
 Thu, 25 Aug 2022 10:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
 <20220825164103.27694-5-andriy.shevchenko@linux.intel.com> <CAJZ5v0if_gZpibSWx5mfoVpGXtF0sGe7MY+eRQJr09ONX0Q1rQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0if_gZpibSWx5mfoVpGXtF0sGe7MY+eRQJr09ONX0Q1rQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 20:17:11 +0300
Message-ID: <CAHp75VcQkyCOo9jkKKmu=zgHgQiHD96QhTa9Ann3syTaVnBokQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ACPI: bus: Use the matching table, if ACPI driver
 has it
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 8:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Aug 25, 2022 at 6:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > In case we have an ACPI driver, check its ID table for matching,
> > This allows to use some generic device property APIs in such
> > drivers.
>
> No new provisions for ACPI drivers, please.

OK! I will think about how to refactor a driver in question, so it
won't need this kind of trick. Meanwhile patches 1-3 can be applied
independently, if you have no objections.

-- 
With Best Regards,
Andy Shevchenko
