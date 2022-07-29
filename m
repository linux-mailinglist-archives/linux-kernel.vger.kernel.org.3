Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016F584D71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiG2IhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiG2IhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:37:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC082465
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:37:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c131so7060566ybf.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBtukp+iT13bXS1x4ppbbvLuYQYsK1bKT1T8ZuQYnuU=;
        b=i22YIsoLhKb/wfkY6xp7KMmlRGqwFcE/LUkGQHT3XnBPKXflWCLwDnGhe3Y2v4aBGb
         1bUjxWV41SVHBYhWtYuWL7UwmcyfYGERtfCq+CIffVBUqZMKfwET2uQrvA9ZVJBGytX+
         j/oDivxugVZ2IhpyVx4ou8gTGgTwu7zrhtVng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBtukp+iT13bXS1x4ppbbvLuYQYsK1bKT1T8ZuQYnuU=;
        b=UkGuwxhk+LXjlwkSURO5ZptCo/Giwx0eRw6q03lIwWm1Dbuc9VTXkyzQLCINsFLCD1
         6fKm86Ul8nPJW3R6FebF//RQolJI+DeXTkrzaKv3mWuUv33RLga86uDJia3ICWRwP1CW
         d9W+2CiIAMqBcyhcr6bN+9sChoJc3aexoQqRec2+4nxBNMKXBqzFYpW599UVgbk+Xq2U
         29bbS3smdPxHiyHp3bxxmI4LQEnaHf/HYmaUuuFfymsHMVyawTKGTn7ar5Dq1mMbmYdZ
         38ebrmrsIsbKrXxGPDQtFvi/q/EWKTmUjFUQQYx2cg7j48HrEvOqYsgnjpqcWOOzGw9s
         HM5g==
X-Gm-Message-State: ACgBeo2n20eYa7/vKrO62weD/gJdYeWiNNaPfQB7iuL9AsrFcfXVaxX2
        dkJTemHqU/KI2BEaJ9bEU3jj3ngqp/1fMzHD8lk9Tg==
X-Google-Smtp-Source: AA6agR4Fodc9JOFrHAphSV1LJgvVUjnQBZ8rGzgsx/oQkn3dAk23lZ2WjEVH2IM56ojvT4WwwhovvzIy+j9G9/w1IU0=
X-Received: by 2002:a25:8888:0:b0:671:787e:8b3c with SMTP id
 d8-20020a258888000000b00671787e8b3cmr1820668ybl.478.1659083833529; Fri, 29
 Jul 2022 01:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220729020508.4147751-1-dlunev@chromium.org> <20220729120216.v3.1.I6b7934b96fff0d5ea22531e57c0a11f0ccd1acd8@changeid>
 <YuOV6l/7KoVO4yZp@kroah.com>
In-Reply-To: <YuOV6l/7KoVO4yZp@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 29 Jul 2022 18:37:02 +1000
Message-ID: <CAONX=-f=qnUqVCTuotrEp6MCMk_f+wWj4FPY6skXHHWuitqZiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ufs: add function to check CRYPTO capability
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a valid changelog text, sorry.  Please read the
> documentation for how to write a valid one.
Sorry for that. Though the latest patchset is v4 and that one
doesn't contain this patch since Eric Biggers pointed out the
crypto information can be obtained from device's queue sysfs
node. But I will try to be better further on.

> Something went wrong with your patch, there is no --- line, so git will
> apply it with the diffstat, right?
>
> Did you hand-edit this?

Hm, I don't recall hand editing it, but the possibility of pilot error is
always there. I am still getting used to the upstream tooling and
processes. Sorry for the inconvenience, but as I mentioned, this
patch is dropped in v4 version (and sorry for high traffic of changes
on this patchset)

Thanks,
Daniil
