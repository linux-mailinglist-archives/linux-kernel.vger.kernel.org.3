Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E4510B92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355578AbiDZV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355576AbiDZV7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:59:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD33EF1A;
        Tue, 26 Apr 2022 14:56:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so15599545ejb.4;
        Tue, 26 Apr 2022 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=3aaFBL0sCar/SwIjO1sWkrvo5C80ephM+JrEVNrL9Ag=;
        b=mU23tWnGzbg4SVZ3Mtv6Lft2tIl1ezpu/mzt++x72A0ZrPe7IRCa4mXpckOcZa7M+Y
         2i0VDRddrirMytrSHeMkZ9GG2uJ/WV8nGnt8lsbwF/g8T6w/28erIhgmDTBVNcCVirTO
         mJ9fpUh48oVy84nkRywL2PmkQx+yJpJfBSE9dqfvkbKbKfCyvR5N0RXoud0U51GVBL/v
         qDsEWBY8xsVerd/QcekIhND7VR+gS7nw7Rl8XEqLEAyKVbsaO2z4ump5yeczrU6SoK3s
         wsPJ2O+l0Psz6uJsikxDXWgnEmdyA8Swp8o/a+LJKGUn6CkS/+pCaID/4i4ITnGqPpIK
         EZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=3aaFBL0sCar/SwIjO1sWkrvo5C80ephM+JrEVNrL9Ag=;
        b=oaGRHY+t4EPF/UiLKqqlvLFxKPjJlNQUkNXQaRc/yTnYNfPid5qE/wYdQvQEvLpsWX
         0qFMwbXgTn0tzwwnHN/H/wfNBp4TFgviZUKXMqLZC5HfW20A81pzkposneVAyxAx0Gtm
         RCP23PMOXKfQsH6LC8jrfQz7rqSIAwPaP7v9xxA4e0k0A6Zn3142/1cCidyn5NSGybKt
         KkkouSB7vrJRcfNi2Za1Ffr3PV4DXXqRSqoD344mvVeLveHaK4XkNpzfrgzKoB5dreW0
         SVSz6RV0Z9FLUH5RJGC9/j61/aHpZvXKv2qAYyNkC4f+rlo0/mS0Q28eG3J2Sl9NUE3K
         6X0A==
X-Gm-Message-State: AOAM533GKQT51Vg9GtNl1mFus13SF8t2ITQb1k+ct8xhWhEgsqNlmwKE
        j75Zmvrgm4wSBIQXtU44g2o=
X-Google-Smtp-Source: ABdhPJwqMdefD2U+ag6cFf20X+Dd7flS1d/UHu9aB5cs23uJZQuS82AsFrb2bEGN6w6XbcCdoKFR0w==
X-Received: by 2002:a17:907:3e92:b0:6f3:8ff4:66b2 with SMTP id hs18-20020a1709073e9200b006f38ff466b2mr12438037ejc.697.1651010174986;
        Tue, 26 Apr 2022 14:56:14 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id ak18-20020a170906889200b006f39a445b93sm2780717ejc.141.2022.04.26.14.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:56:14 -0700 (PDT)
Message-ID: <05a09a87d5fa79fd1eb93c3e4c879112f48d4165.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_*
 prefix to start with rcmd_*
From:   Bean Huo <huobean@gmail.com>
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Apr 2022 23:56:13 +0200
In-Reply-To: <1891546521.01650859681867.JavaMail.epsvc@epcpadp4>
References: <20220424220713.1253049-5-huobean@gmail.com>
         <20220424220713.1253049-1-huobean@gmail.com>
         <CGME20220424220757epcas2p37d7fcf3c58b1c29291f6e6765e6690ed@epcms2p3>
         <1891546521.01650859681867.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 12:43 +0900, Keoseong Park wrote:
> > 2.34.1
> >=20
> >=20
> Apart from the indentation, the patch looks good to me, so once
> you've fixed them, feel free to add my:
>=20
> Reviewed-by: Keoseong Park <keosung.park@samsung.com>

thanks for your review, I will change them based on your comments in
the next version.

Kind regards,
Bean

