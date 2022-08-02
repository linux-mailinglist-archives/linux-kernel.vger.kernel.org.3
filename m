Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA55884F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiHBX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:57:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2DF26;
        Tue,  2 Aug 2022 16:57:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m22so12315157lfl.9;
        Tue, 02 Aug 2022 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1cg93yqJyafdpG8s67QRUD8AgOSMfWbzD5eV2X0T+hk=;
        b=cSM7f1oOewo3sm1q3jb64L9EjWKdctaYd0+/BS/BDbL4FhRFQTfCY6TRBYjuxBBHSS
         Lim3czZia2zXih//SdtF2theBAf2N9lV4PzGQ7jdowro0PprJ/H0yx8ia6omXdxDeBcc
         4EFI5Zr1mdiiXcB3pvxnUb20RD+ONbIE73bcmtZpVNvODCEjP05C+3BrI9uI2lg244pQ
         LIm0vCFWVQ7vtNPn6d+Ih8spGtLHdioRJskgjZVJzP4/kB9fhJaEja7l+BziPNB7JJfZ
         YclezaNXGxP+MmGDAdA3FtLS+bxHawMHal5BDBJgyAT+SqBWYVKKmrkd8lLOfGFXn6uU
         Zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1cg93yqJyafdpG8s67QRUD8AgOSMfWbzD5eV2X0T+hk=;
        b=pftDjtpciKpuAL2pkc1KFDm7e181iWCZS7Wy2QEMzMPwCIwfPp0ZOp5iEGQ4pgRmiZ
         zLcNiRjJKYCdDVZJOxCXAgxGhduEvCsFG7yUDPqstDDTKiJuS+XShEtga2eboxoaTFNu
         idFuoeJJXE8m785J4SyCv7s5aQ/WDnptfZ99xnj/dwd0NQmeePrhH8E9NAaERmBvtmSx
         2P9T+sjU2zDyaBgDQxw8oSZe405YYl89jDp8dc6LDOZlycPSbxMiQC0Yu4Njlkzkyv/z
         GHouAsCo1nOFWV8XaqHee1rHIXCd7+IUvP42EZ2nmoGZsqPHLJ01rVIbr+U25p9oj5BJ
         zsNA==
X-Gm-Message-State: ACgBeo14vweEinaLfhwEwCRyjrGerXWtVGl3IEA/02Cksgkr7MVBLG5q
        OIaC/LqX3fpuXyCa2x/wcSQ1bofM+qitbtrH3g==
X-Google-Smtp-Source: AA6agR6lLhObT3q9+xJ6iO8J7nfPdTYcZkfXA5luK2os7jWt0xqk2E8m1lcHs3xNeIp3jVygTVescaBbhH5Slar14+A=
X-Received: by 2002:ac2:483b:0:b0:48a:e7f2:c7ff with SMTP id
 27-20020ac2483b000000b0048ae7f2c7ffmr7507089lft.591.1659484670751; Tue, 02
 Aug 2022 16:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220803074349.v4.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
In-Reply-To: <20220803074349.v4.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 3 Aug 2022 07:57:39 +0800
Message-ID: <CAGaU9a8H7QmkhBvNfZhH+CyFaup1oGX1j7a36ph9t+Me3MjCQw@mail.gmail.com>
Subject: Re: [PATCH v4] ufs: core: ufshcd: use local_clock() for debugging timestamps
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

Hi Daniil,

On Wed, Aug 3, 2022 at 5:44 AM Daniil Lunev <dlunev@chromium.org> wrote:
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
>
> ---

Please kindly add all Reviewed or Acked tags received in previous
versions to any newer patches.

Thanks,
Stanley
