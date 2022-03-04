Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE34CD68B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiCDOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiCDOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:39:47 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0F17FD0F;
        Fri,  4 Mar 2022 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646404726;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=5Qc8A3HzHhhVNwswhRRj+dDn3SjBwurLJjNxoV7R1h4=;
    b=ZWw51Qyh1H8Owiia7uxcWPNiBl3gL10SUU9XRamoz15QEdxsxoeJRv5aSZTH4fuNuC
    QwGkfOIEgNhztWx+I9k4b+7u+sZkiQrgpr/SoNSDN5u8DEq7sSncY6hDRAqE6/43zUQb
    a7a5F+qZ2HZP9+0jSLHVE5qpzamOQtdMG39hdsewq6T/1ij05XpW4+gn6cY4Kn3s4CgR
    zazAMdRWPZlHztPwJTMaLzMoWmjXql2WbLgYu30NlkSJJdEKImPoMuWWud4HXOyCvQLF
    fp9IKN4W/lnAKc4ax3nzs9SdJL+n72Glh6I40Gw0osSd9JPTsXI/jHqodD/IgpEPSnwr
    pXXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8QUWw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey24Eck6dY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 4 Mar 2022 15:38:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for
 MMC_SEND_OP_COND
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220304105656.149281-1-ulf.hansson@linaro.org>
Date:   Fri, 4 Mar 2022 15:38:45 +0100
Cc:     linux-mmc@vger.kernel.org,
        Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE1CAC2A-C06C-4E1F-A391-A063972A34A2@goldelico.com>
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

> Am 04.03.2022 um 11:56 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> significantly decreased the polling period from ~10-12ms into just a =
couple
> of us. The purpose was to decrease the total time spent in the busy =
polling
> loop, but unfortunate it has lead to problems, that causes eMMC cards =
to
> never gets out busy and thus fails to be initialized.
>=20
> To fix the problem, but also to try to keep some of the new improved
> behaviour, let's start by using a polling period of 1-2ms, which then
> increases for each loop, according to common polling loop in
> __mmc_poll_for_busy().
>=20
> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Huijin Park <huijin.park@samsung.com>
> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>=20
> Jean Rene and H. Nikolaus, if this doesn't work, please try extending =
the
> the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that =
always
> works.

Works for me.

BR and thanks,
Nikolaus

