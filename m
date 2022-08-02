Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD23587598
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiHBClo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiHBCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:41:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7541A385;
        Mon,  1 Aug 2022 19:41:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so20076005lfr.2;
        Mon, 01 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RVfAHvJmZZxroMpdSEie4EQQNZ/UFzH3/yFbd38Icu4=;
        b=ZXwelcGKwyoUObgIU4lZABQ8/1Vwpwlbt5cDHwcZx5PMKRbepuYXiGsb8u+lK7IFna
         U+tYLkPTFV08dbmA+VPkTGpRRBawhikVkgiXCEy3WIH5xtcUrAtylMLWwcvUB+Zaz2w0
         u+jFyT4RpHrw/VEZ3dEJDV2/CW7qW44IN1EL5MBm+Z6y1grXPH7KqXTm9KH99+tRxreP
         ReM2EKe8tiX97vfM22C7+bQu+LpsTmlnld844aH+r0+8OeCIRvWIr7AWUVzA6CmYQ1Qs
         F4k8QUjYsuhPI+lia0qSJeZyQrNFgrwPIvLnIAvGS/0js21aecAAB8jQUEMU8r3aCiNo
         WQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RVfAHvJmZZxroMpdSEie4EQQNZ/UFzH3/yFbd38Icu4=;
        b=4ZjIq4Nl0muskIsf79jXj/DQ31Q+ubGSXwpjLFLm7pi+rHoH/MhD+M2+oESct0fBk9
         2tW7UG1DHgugtZhGCOSYEGvQv9aJ0djbI9XbIhuiJERyYPLd9Vn6Rx4Zrgbl377LNkji
         byot1KVy7kpuXjEif+PaCrBSz2ykOkbys4RoZiKMEocPFLvvGf81aiec/SS1d+u9AWDe
         G3mpTBO5gEaIKOeyqmIuvejP5YFpB2UTCSY0IKoBnjt7juVQxjhwN9vORtNLrCy8Z32n
         Nj7h07byvaP+4QS36xywIWjAH2c8vz7uQLViK6s/g4KO7Ntg1f0CRvX/mNaM0Sos6j84
         OkoA==
X-Gm-Message-State: ACgBeo1L3rvbWm2aoD9rOSnDFVCARE3nlwH0l31gWsMPwUlSvyiP5eQu
        e23IcaS7MKtz6t6CyNA9LhYisx1TP9EcDk/zhA==
X-Google-Smtp-Source: AA6agR7jKTCbap/c8xnR4bmmgRogo8a+0GpwQTpFundzIS8X2Xawj2Z3G8d4qMRgGEpeCImxH2a5Rzhx8j9xtyjQs9c=
X-Received: by 2002:a05:6512:3096:b0:48b:4f7:9019 with SMTP id
 z22-20020a056512309600b0048b04f79019mr1317541lfd.208.1659408098275; Mon, 01
 Aug 2022 19:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
In-Reply-To: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 Aug 2022 10:41:25 +0800
Message-ID: <CAGaU9a8BYcymZBKp9YzyAODqEmGt88woEoEMKY+ShCg=X1eAgA@mail.gmail.com>
Subject: Re: [PATCH v3] ufs: core: ufshcd: use local_clock() for debugging timestamps
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

On Tue, Aug 2, 2022 at 8:32 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> CLOCK_MONOTONIC is not advanced when the system is in suspend. This
> becomes problematic when debugging issues related to suspend-resume:
> the timestamps printed by ufshcd_print_trs can not be correlated with
> dmesg entries, which are timestamped with local_clock().
>
> This CL changes the used clock to local_clock() for the informational
> timestamp variables and adds mirroring *_local_clock instances for
> variables used in subsequent derevations (to not change the semantics of
> those derevations).
>
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

Acked-by: Stanley Chu <stanley.chu@mediatek.com>
