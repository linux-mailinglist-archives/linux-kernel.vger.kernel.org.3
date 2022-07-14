Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF19574C29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiGNLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiGNLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554592DD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:32:51 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJEIl-1nrFXe1cVv-00Kdya for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022
 13:32:49 +0200
Received: by mail-yb1-f181.google.com with SMTP id k85so67651ybk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:32:49 -0700 (PDT)
X-Gm-Message-State: AJIora9jBdx+mBTMyZaubzaIQgJY8D54/cGv83xlL1SSLXHYtnfCT8jS
        2Lnt+SJiVlL9HffWkWHVqCBmyXWg/Biu2SdZVYM=
X-Google-Smtp-Source: AGRyM1vE8JYz3xOgLE6KMkE+pATDrszzSzapNzY6x8GDhIEZ6wBc62gMnHue2h6Xki51q87PhzPcJR5Wjmahm7Wormg=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr8111642ybc.480.1657798367361; Thu, 14
 Jul 2022 04:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com> <20220708094950.41944-2-zhengqi.arch@bytedance.com>
In-Reply-To: <20220708094950.41944-2-zhengqi.arch@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 13:32:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2kgVikkKBZLa31XUopEFa9ykLS=qxiH=qiFD8HtUvw=A@mail.gmail.com>
Message-ID: <CAK8P3a2kgVikkKBZLa31XUopEFa9ykLS=qxiH=qiFD8HtUvw=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: run softirqs on the per-CPU IRQ stack
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RFExNZXlg809pui/N6iIRljogisu+/zTQgOhqu9NNeiGV7mQ54S
 B/IqDbPHE78JAO9nBpz3OI1FuPohdUTEcQo7P0bry5YCM0ep8EvL75hAef63Vt/Rb2n2lWI
 eJzfX1qWIs5v833Kth60ixXiItD+n9xSE7cD773EjZBiJNNUk3FRXTUBU7yG7n0utWF/IhW
 uQYeWEGlG7q2cRH8H04yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UyCmE2kLzG0=:e05QBLm5ryVI+UCaVJpMgj
 gz/YRKaOPNixDJ7px4XEY4MJ6Rh4WFcQQDa8fcktr5rm3629CFTX2mm98zD0zdePlri4NqV/U
 0ky+zQZ5vD/zWPyH1M/S1qHEFbp4Y2rN9h6wP8NcgbRlqF3ayVMuZ9NIKjqxPhVN3xr+uQFpj
 ZROX2gXxsSs1sE/1zDtJ7Ew9FhFisbE3rPNZKO5UcMVgoNojK1jaT0WIdeGUtAYYSjucwAYoW
 nENyMLFvs3ZPWXuHcqtld4qxEwsiQC/oPYiLPrM1L/xMOjbss65XjLy6lwr+gN51OApvmZK6L
 zmSwVFwer9l/E0j9dQKzcLXC2FpvAqyHmS40Z4E51W/G4/6NuDUrd4zbyNHFbiRHjZj69QCfC
 hbfbZWbwoZw5ofzJCxcrZyG4+YAemz6HlwQxxywkQoZlOd8StgFIuI/8mJcQBPdvOPSShlqHc
 Jcji4pgUGvNr/EOJV3zQOke0ajFnZ8DGCp2iyqZWQIaZCYeDNIL+wtEz2Bu1g2dQgAkbh+f0D
 vGVda7Mbzoodeu8P0VJ11B89AkUS0xoGjetgmfQ3DUDtCFwa5qGI/bJmvefWm3u1GwLD/PD87
 o3x6Mc8QZpSEyvnxOHGxRpfvOXvDWtlMBUNAFRA9k/0kgtYniyVvjSTsU8c93CVh+T0pax/Vl
 Mv+6lGU/t+6XzVeXNKjzzKuTF+C0O9IfZByGhI/I76TJi4vlN9rQXDGucMdXArfk1tvZ7EERj
 a18AOTzooY3dHQt18Xp/k/XGD1Jz/87PRVtGSAANGSM2De8ZLiGxLNueIyDLU5z19FiXnb2+8
 g4izuGB2Nk8ff+l1lFrlrLmiQzimGDCPbQkeK7+rpxNOfVs6MVr+mGV+Kpl7wZ52P3bXUcgJ6
 bb2hNlkpUhqPbTXr9g3A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
>
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

This seems like a nice improvement, and this version addresses
my concern I raised on the RFC version.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
