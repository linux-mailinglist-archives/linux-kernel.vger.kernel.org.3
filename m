Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0105856D152
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGJVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:04:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6DB1E8;
        Sun, 10 Jul 2022 14:04:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu1so3548872wrb.9;
        Sun, 10 Jul 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=s6LbQM60a/NqHe5S4pnvhTpmiE0Eg2MNhuC/jd2DU2o=;
        b=qBn6FOYr6AMBjvptOeqteAc6Qko5jEM3J88iKADzmtdIsS5MQFdFupT6h20gOop0yh
         WnmirNoIVOmsVsTYrVXJpqubVe9WTYFffRnjsx6sRepxszPSPVC3Wukzk8b4FZxIF2bg
         McWsB8Ax4xGaeBe1UwrITGLpEYTcwSsrCo1zfWAyYkbycB0fDoShX/jLqAWpPelIK1US
         tJdx0Twfh2ba3rnTTDlZrL6SosM0/iHuw3Gxu1IGyJwdfdGgeSQ8Mnj+sdty44txHAdS
         urcE9Ybe6rqASvZCFsZOzURTvuK3EP0lNVpsbpR5lqaF4Mk13wJf0IV7C+PfVfJkcCyt
         rYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=s6LbQM60a/NqHe5S4pnvhTpmiE0Eg2MNhuC/jd2DU2o=;
        b=SA+cpnrN6tu5TSxo2eRtY/kOeE7bCsh53FwJCFhivsjKlkcIHzD4aT22IXmrMp93/q
         Rr2RvSfYTkCZbNhATm1Mu0Q8Yz2gPA3ovqvfGqfXNo8kF1jYQ+nfEE8R5GmWPzE0PueS
         PYk5HgdHTDHoU3upxZT2VLgpFyMwBF2wViBkqM7tKzCGWo/TTDzsItGFTqcqaQjJvjQT
         HNmyDZHaWrWpdXa2Wfb1F6WiWOq2lB/+T8DA0F+YEy6DblbmvAQE1v2NF9w1ursUyzB/
         10+qHfwJjWDc5bhaWbUjrs6cuBLExHH8mwxM2VtIAufrTtSGkJpiYhn+4TNehyrMISKj
         d8/Q==
X-Gm-Message-State: AJIora/Kn1M7dsDXQD7XvNLyuMa/BILVvQpRDxkf2zBeKL+npxkRWEfS
        f2WITDWgm0qbjrnY2ZyXgy4=
X-Google-Smtp-Source: AGRyM1sQ/zPTymAOK6X9TDBMsxNNNqeZdfMJEDtRDgbAE5drkw8wJbrJvVqvUbIpGL5rR9mqOjkZRw==
X-Received: by 2002:adf:e652:0:b0:21d:6e43:3ec4 with SMTP id b18-20020adfe652000000b0021d6e433ec4mr14659078wrn.358.1657487093535;
        Sun, 10 Jul 2022 14:04:53 -0700 (PDT)
Received: from p200300c5871c95144a9b1f8252dc9b80.dip0.t-ipconnect.de (p200300c5871c95144a9b1f8252dc9b80.dip0.t-ipconnect.de. [2003:c5:871c:9514:4a9b:1f82:52dc:9b80])
        by smtp.googlemail.com with ESMTPSA id o9-20020a05600c4fc900b003a2e51bbbb8sm2633840wmq.30.2022.07.10.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:04:53 -0700 (PDT)
Message-ID: <1b3517b793fdf9523e7156c77c0f86e9af4ff3e0.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: ufshcd: Drop loglevel of WriteBoost message
From:   Bean Huo <huobean@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yue Hu <huyue2@yulong.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 10 Jul 2022 23:04:52 +0200
In-Reply-To: <20220709000027.3929970-1-bjorn.andersson@linaro.org>
References: <20220709000027.3929970-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 17:00 -0700, Bjorn Andersson wrote:
> Commit '3b5f3c0d0548 ("scsi: ufs: core: Tidy up WB configuration
> code")'
> changed the log level of the write boost enable/disable notification
> from debug to info, this results in a lot of noise in the kernel log
> during normal operation.
>=20
> Drop it back to debug level to avoid this.
>=20
> Fixes: 3b5f3c0d0548 ("scsi: ufs: core: Tidy up WB configuration
> code")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
Acked-by: Bean Huo <beanhuo@micron.com>
