Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE32456B8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiGHLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiGHLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:52:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF869A6A2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:52:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h132so6668338ybb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4hzt77sanl4OybV4ll2qZvZornIpnMEtwCEQsVUpu4=;
        b=D5y2O/kkvS+CRB8fj92t7iKlVyuHdQESuCUs/p3FgADXbO6y1G3FdUfOF1yfIDuR+Z
         3WQf06bZk1iqCiBKMp5uzySzucvM6b8uW7TMGetw8P+CI2eAmsly2Ytkp7ZGtXmIC0Zq
         W21r7UU4CihtkIZHQmMrKgnA4v1T8FlbpxnTBnffXyfQXInF3p8sncPsi8JE51/dVdmY
         MZgdMyCFvXfjm20CqM7GqH12Rgg9uqK6hKzq8qhVlmlm16xtwlbFiz4q+a/bdgpuTvb9
         3J6Pj1M1X7i2Psd5XxEyPYEfbrNpPD1AH2XZTMWK46B4HX2ccgFLpdRYEMj7qp501mUW
         rr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4hzt77sanl4OybV4ll2qZvZornIpnMEtwCEQsVUpu4=;
        b=WmHve+G6NqOva3RcdVJlRDdHriNNtEBO1g/LL7fiBzFCjNfGqd3DiEL/DkQiP2+27c
         jBi9Rer3BSmDd7tp175h6hyno0XN0koyVdSCgtpD2gQ7YL2PSb1M1RG8I8L/tIP+PF+I
         xNQiNKWJUW4Ufxr2uU342xDObhRUJLTTr2P4nMN7UXXHkKyJGHiehz2UPTBf3OS0MWjq
         AASKWTANcoVOSFSRNid7SUCWT2ND+Uq/4mRyi+uzApdjcWtTq0hd0srvxoQnJmWgyBay
         gIke+wIjp50ZWLym6NdKtIczCOtSF2XzQi7n7b5FFb1iO4v+j/4x6CBiLR5LeR/K46KJ
         cO5w==
X-Gm-Message-State: AJIora+UgBCdAmjSJB9OSgjDcRkmekoXkimY4gQE4/wKbTdtUpeK378u
        TdFVciPurjY84Ele1QF2nsFcH4SDbQIBVkmn9qY=
X-Google-Smtp-Source: AGRyM1tbQOwiUHCoYkN4fcmHSA8js0cP69cW4gnzfEMUkgBIihh1W9OirKc6KveGvY3N/3TIrYhNa8nRKpM/FxeYtaU=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr3336466ybk.296.1657281129161; Fri, 08
 Jul 2022 04:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com> <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
In-Reply-To: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 13:51:32 +0200
Message-ID: <CAHp75VeC2b1PbzTHr-pnG9Z4d9CvYZvszz-7gpLZHhJiCw42Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Fri, Jul 8, 2022 at 1:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jul 8, 2022 at 1:33 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:

...

> Taking the above into account, please try to use get_options() and
> then tell me what's not working with it. If so, we will add test cases
> to get_options() and fix it.

That said, I would probably expect new cases for hexdecimal input
along with using unsigned int * as an acceptor to see that there are
no bugs related to signed vs. unsigned.

-- 
With Best Regards,
Andy Shevchenko
