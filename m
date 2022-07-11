Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C24570A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiGKSys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGKSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:54:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF3286C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:54:45 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mr8SG-1noWDy16m6-00oIP7 for <linux-kernel@vger.kernel.org>; Mon, 11 Jul
 2022 20:54:44 +0200
Received: by mail-yb1-f181.google.com with SMTP id l11so10181927ybu.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:54:44 -0700 (PDT)
X-Gm-Message-State: AJIora9Iq+JcgESMnzowEHyTA89OUHlg8yjRhMRCM8zxw/J0GxkB8JFH
        3b4r+5kaJggYZT/BG/fQzcplboSWdbBG+ntyhSo=
X-Google-Smtp-Source: AGRyM1teQ9by6wwYpEa4TUiw+qV+gY/b/EQAj5dDeWf1gTsk/iOKJ37ZYiJsFa3tHVGbiKmMuKCKz+TO3trwL567zV4=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr18584569ybc.480.1657565683096; Mon, 11
 Jul 2022 11:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220708194448.10700-1-Sergey.Semin@baikalelectronics.ru> <20220711155335.ltctlk66vylwcpcj@mobilestation>
In-Reply-To: <20220711155335.ltctlk66vylwcpcj@mobilestation>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 20:54:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2H0+LDO18onn3F469t4ci=VbL+EZV83dct74Ce8tqfqg@mail.gmail.com>
Message-ID: <CAK8P3a2H0+LDO18onn3F469t4ci=VbL+EZV83dct74Ce8tqfqg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/2] bus: bt1-apb: Don't print error on -EPROBE_DEFER
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nOCKlvN/fQTwf+TuLkYHB5kka8JYYHX4z207CMk8nR1nfJ61ysM
 q8BJKzh/yAfVD2AnaBX7i7IRtIwbGPfZlhiWT9pUmn4EmDBNLJ9F/XvI3yCBakrMHyfuZcE
 0qESpamgUFp9v8exZJKF10jMss8cb3Rt8SRp+oNWemtvXEkXbJBhiGm1Sjxm/RRCz3BobQz
 quNtkGTdGEASIFsBdDRVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vve9IZ+rZmQ=:xuPaansrjs143YfxHhYuUQ
 O5RN0O/3tFkuOCFfjths3/Rp4nABdSlYFdu3xNBgj5VeH7OQubtzeIJg08qlursNpmH8LqQa/
 B9cOukjQzcT9fvmJlqtqd+wQkSn2/4lj1QoLKmySh5iT65mxBEE1BAVRecLRA3ML7UjTy7kFz
 D/EuM1yIzstjgnt/FTXjXbiBl6NC0UNNx4e3pTXWqq8R069Rhc1B54alWLeuuM/V3iWkDcTwl
 vQJbPMGs3Gxlm3mi0exXFZ+kEybKiYQolnjv0CmWtS70Nw6AhXcLl+aqf8h2EKQjojFHUJPAZ
 mZBihGmtwAkZjfeul6UMfXjfQo5gQJTp8tbAIraW9YlRUcxPKATuWanpkwdpD7fO6TWFk0HJx
 PHoMAOaoJCe2QPmX9W2qP94ozBAEYnC6GyM6H6O5J1Eb2uhnFIVYYnyCKfglpvY7/tXOlL1sa
 J5y2OFOqaqyCRdwGIaqrK6zNtuYgqJ8VVbI+hRHXiHchD9ffbp50Tmge0KUS+n5Zg8MpfFPHB
 brUpBlDANQG79NIZ5Z8VTODmR4WnZWNu5YvYBJPJj9LpVRlNRPr9oOUoXCv0cqONWFWywL4P1
 OPEvksD8yDeOrv8Bp6XEiE6RPh1LWmKgXkvVyti+M3mc2yfGfeUanbk6zgnyCgog6KtD6HluP
 1LSezFQpRp5lx6dke5MhOxT7E12Df51q6oTkxlpATWSxx4BmPJSTwHM5K9m5yTCl/gBR63udK
 HOpU7jbz2lM/RA6n5+Z88Fr/fiKJnSX8PVQ9aGk3ft3HFn9XzZMngSe84R34K//BEr/mnltgk
 QWMAj2eQAFpGGcDU+1KHfkbCf8Ja/BiodL+Jhy2nbsPNXsor/5agup5gJWT8jj77jhjgzsoUn
 6oNzsfB0v5lnunvHLa5A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 5:53 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hi Arnd, Philipp
>
> Since no comments have been posted for the patches lately and the @Philipp
> notes have been fixed way on v2, could you please consider merge the
> patchset in through any of your repos?


Hi Sergey,

I already merged these into the arm/drivers tree on June 10, I suppose
something went wrong with the notification email.

      Arnd
