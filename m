Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE235827FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiG0Nth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiG0Ntf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:49:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA41FCF4;
        Wed, 27 Jul 2022 06:49:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so31635467ejb.4;
        Wed, 27 Jul 2022 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Vj2LN4XjfRsXRFnZMqSEcbIyXXU8xmtwUttCD6kAXxY=;
        b=Tb1b90evxLS7TTWzEzwyBCgrmxz0YM5dpAy1/F866dZvLHP68FjWursIw/ySDWRemz
         M4p37SafJefIepx9cOHQphOJBtw2M9bTQv8OPsD/TPPsfz+VmxzjGI2ZFm9kgDYQJ/3p
         JkZeU3KPSVquIDVbBgmavOBBrpeGo29c+i4refDoKdyOcHqXGarok1ddZ30yNuzy5gE3
         wXLQwFv7f8y7+KTAOJJUqVIl1eZNRXoz3TWP5Ii672v3E8jAQPa7yDcpaTZhDz9afU9A
         b1quhZ3UpBdkecCrguHqvUoysqSPf7YJ2KqR5wvPjalKbW17jUg3UvnNWQ5P7AcsKO7u
         Wruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Vj2LN4XjfRsXRFnZMqSEcbIyXXU8xmtwUttCD6kAXxY=;
        b=7u3i9z4wj9FG66Z0YZCAoMoSrio1x7MtH3ZVAMaoRcv2EPuxIhSXthz3/4zkhPvf4+
         79PAVNET6yYw4MDFl8pCPjJJpgNhOAD13pEer0n2KH6u2b5yVQhUX7LUyzsUchvXhmqX
         IcRLBXA6L+x9C3aLqjTa1rTaZfEBQg75//FEtH8rF3SZfWbUPPSeQ316eyPNsj5mC+7t
         hAadnHPoyVpkcQJ1dYJg8Za4fw+uaBnXDXwj+DBd2EIlefhD4d+U2HN+Tkzt6Uiu3s1d
         iFtvl7X+NcPzmWND41FzAeF9Pcfx4qMEBM5sA3eh+Kmd/5L0YNRouQZ0Us50/1Ag3mPw
         LUXw==
X-Gm-Message-State: AJIora+3ISPd0DC6K6kD4XyAZo6jWabcJBmU3/PcVpdeGBaRFLrDzpgO
        JXonHWXV1mjC6W+HTH05y8o=
X-Google-Smtp-Source: AGRyM1smRBREMExG/t/+rSz8lLFAZH6N4BXeOwq0BEkIIiuFrZVPPHQQeV6ZdJtYMUZ1Aox16zLP9w==
X-Received: by 2002:a17:907:d8d:b0:72f:75:9bbd with SMTP id go13-20020a1709070d8d00b0072f00759bbdmr18076377ejc.148.1658929771538;
        Wed, 27 Jul 2022 06:49:31 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id j15-20020aa7de8f000000b0043be16f5f4csm6799122edv.52.2022.07.27.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:49:30 -0700 (PDT)
Message-ID: <94bcf58b268b1fb468f5be20d9b93bf8e5d3ce57.camel@gmail.com>
Subject: Re: [PATCH v4 2/7] scsi: ufs: wb: Change wb_enabled condition test
From:   Bean Huo <huobean@gmail.com>
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jul 2022 15:49:29 +0200
In-Reply-To: <20220727070522epcms2p5ad2dd21b471acee963dd58b37d35e11f@epcms2p5>
References: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
         <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
         <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
         <20220727070522epcms2p5ad2dd21b471acee963dd58b37d35e11f@epcms2p5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
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

On Wed, 2022-07-27 at 16:05 +0900, Jinyoung CHOI wrote:
> Changed to improve readability.
> As implemented in ufshcd_wb_togle_flush(), the conditional test is
> modified in the same way.
>=20
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>
