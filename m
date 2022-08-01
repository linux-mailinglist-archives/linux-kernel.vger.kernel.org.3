Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECA5863CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiHAFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiHAFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:47:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7E13E0E;
        Sun, 31 Jul 2022 22:47:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s9so5149728ljs.6;
        Sun, 31 Jul 2022 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PcYQ+fcUgJlX8RL6/jWs5A0IQPNtrdQDf9GzcysJtAs=;
        b=P3G7qTgMZPvDy+HkfeTs3cn5goN03966FFWsuKeWsj5lg9BRr9OsBw7WUhQCPIrKvS
         hk0vdh5gp3hgXPTE6unKWaQOMPwCO0uRu4yYyNN0Spjjy3I0aOn6ymYyb+ZGJn58Sxg1
         IDKzpaMQN6ClRKT5dUNZk/ifNZBypx8rc4crC9/SKhRo9CXvZvNZAuVX4CaH4QQgFeSH
         fhQiOjBH41Drq+LyonC18nvGJgGZANRXCx3pHuoKX2jqfKe045qZZ9KWGkfjhS8FHqTu
         tUF+lj5ywdLOpxnfYLhxSmbiZN6pti/8GUALRtmF4pRwgexKyh34fgmGyz9atomyaQ3U
         D/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PcYQ+fcUgJlX8RL6/jWs5A0IQPNtrdQDf9GzcysJtAs=;
        b=sJuS2SHln39mv+lewDppqTrMTAlOEJcztgduYgNuXi2m5Ip5IsSRmpsjFeXlCTJhU0
         gItxAZHMam3EL23gYISrDwelPvteqM8KL9k0eUVhpZHw23Zr5egQk6EmlIKfY8OdnG3a
         EyWIfmo9CHysJ/HnTEG/tzFYHLqL3Q322p2MePwwNKXsduskCwuSEfFR1kDncFKwDzE2
         /MvQW7D7WS5LbGnfTezx3ooSmUN6Q9KYRSUXAF2XHX/nG3DfQ+2NEa02MJn/LRStpZBk
         wGTv5A6n539LXnmZz9Pqb/2RkBdP50JEc0sWl8r74ifBGxwNX73w1ZGPW8iiHhgVWoRU
         tZqg==
X-Gm-Message-State: AJIora/dnCIbOlK8PJpPB4bIspqOFSvfVDiS2+YJns/YQV0T6qGGgrPj
        f3F4o6L9WkWkRBj6qb9jdW028LfsHsUg+8YPxg==
X-Google-Smtp-Source: AGRyM1trCMRHX3F5An/Yod4aPBVSDsVMS6lNxTZ8DZgaq+rRKpoKQkUHzX+fTEXkn/UVShCazadQUP/T0BUglr4AeAI=
X-Received: by 2002:a2e:81c1:0:b0:24b:f44:3970 with SMTP id
 s1-20020a2e81c1000000b0024b0f443970mr4338325ljg.97.1659332836069; Sun, 31 Jul
 2022 22:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
In-Reply-To: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 1 Aug 2022 13:47:04 +0800
Message-ID: <CAGaU9a9YmXDe4z7C8J=4XrjfJQ_wavchpX+QUSJHPDuPe=BVGg@mail.gmail.com>
Subject: Re: [PATCH v2] ufs: core: ufshcd: use local_clock() for debugging timestamps
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 1, 2022 at 12:30 PM Daniil Lunev <dlunev@chromium.org> wrote:
>
> CLOCK_MONOTONIC is not advanced when the system is in suspend. This
> becomes problematic when debugging issues related to suspend-resume:
> the timestamps printed by ufshcd_print_trs can not be correlated with
> dmesg entries, which are timestamped with local_clock().
>
> This patch changes the used clock to local_clock() for the informational
> timestamp variables and adds mirroring *_local_clock instances for
> variables used in subsequent derevations (to not change the semantics of
> those derevations).
>
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>
I am not sure if it is better to keep only one kind of timestamp in
the UFS driver.

Either way, it looks good to me.

Acked-by: Stanley Chu <stanley.chu@mediatek.com>
