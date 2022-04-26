Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AA510B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355573AbiDZV54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiDZV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:57:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD4131CED;
        Tue, 26 Apr 2022 14:54:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so12095315ejc.7;
        Tue, 26 Apr 2022 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Dhakw0e5ZSPa2dy8bzzfO97Ps8/UGe5wd7QSGn6HCIY=;
        b=gJItSOS0nTNbKHQU4XxgReQTh/kj3eAdTGIZa9w3MrS5NEpYCZMBFFTdCvHBEsj6sP
         S83WMM+kpLxopmIBCl9yqJo3JVyKxTbEttoqfmM2qbRgGOerQPp5KCt74yNpc4HixsJm
         +1Z1pywC68sjhdoyLVi23Vp6ZiunQ//XUQTbRSo5TSVC5gU4OsfnyAD2QonCta3P870I
         qVxUI/LeF8jifIEPi2AfNLC0UJlkFLJ3txxKRzuiNSCAS4bfAPGBvILiesvGNcYS6ECi
         Is78Qv9CUc57PEI3NFYNasCiv+dzy+j/dJbxi7JI4dpxAwwZ+0QTEcZNPsDCDciCKqnP
         Ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Dhakw0e5ZSPa2dy8bzzfO97Ps8/UGe5wd7QSGn6HCIY=;
        b=I39h9ko3ZeeQJPnMVIEgEnUcpPumAw81tXQ1cM9xzpWreyrT280q3F1rQ0RTg6VgkJ
         ikpTGueK9futm7TwMMOr1SeSRWxUoxlF1AT2kzWuIL7KVb0cgf2qn1TSozPvPGOW3f6j
         ktQPnlouvipUYonVustYhGjwnJJOtKJlu17T0TDiQkuigTy9NH4JtwCj1b50u4g6UWoA
         okb62koh17ejBr3ZOQz9xPV78rUQuNFWT25bf+5oPp97aXlkgMh+/8L0SaOI+M6m9mX9
         9xqEAMOESxyMIUK6nMlk/5eNvO5hxQa1dEr1E0ItfGcTe3/awaVTcG809vUrhSNz/ufC
         mgKA==
X-Gm-Message-State: AOAM530K7mqTH+EYCUDp2ulFXoCFDjIN+A3y0ggGEJdDDLYamPcwnJXO
        UmxjW0NIbFdweEgRISwVnss=
X-Google-Smtp-Source: ABdhPJzwF+HfRP7B8GgzbotjOCS1lC0d1TCWMzpZsk90rO8q1zat42mj87yp/LggtF+L0L9D2wWW/Q==
X-Received: by 2002:a17:907:9628:b0:6f3:5fbe:c28 with SMTP id gb40-20020a170907962800b006f35fbe0c28mr21508181ejc.754.1651010084934;
        Tue, 26 Apr 2022 14:54:44 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id ia5-20020a170907a06500b006f392df973bsm3139305ejc.107.2022.04.26.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:54:44 -0700 (PDT)
Message-ID: <e422b442c3d56074a11c122dacc9328b1c74fd76.camel@gmail.com>
Subject: Re: [PATCH v3 5/6] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        keosung.park@samsung.com
Date:   Tue, 26 Apr 2022 23:54:43 +0200
In-Reply-To: <DM6PR04MB6575DE756EE25ECA7DF17669FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
         <20220424220713.1253049-6-huobean@gmail.com>
         <DM6PR04MB6575DE756EE25ECA7DF17669FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On Mon, 2022-04-25 at 06:43 +0000, Avri Altman wrote:
> >=20
> > Therefore, for HPB device control mode, if the UFS device is reset
> > via the
> > RST_N
> > pin, the active region information in the device will be reset. If
> > the host side
> > receives this notification from the device side, it is recommended
> > to inactivate
> > all active regions in the host's HPB cache.
> While it makes sense to me, this interpretation of the spec takes
> extreme action,
> Compared to what it is today, and you probably need to get an ack
> from Daejun.=20
>=20

Yes, but it seems he is quiet. Keoseong Park is on the email list and
he has looked at the patch. If you have concerns, I can ping Keoseong
Park to sync with Daejun.

> If we are entering a zone in which each vendor is applying a
> different logic -=20
> I think you need to facilitate that - maybe in a different patch set.
>=20

Yes, it should be a different patch. I must say that this patch is
based on the HPB Spec, say, if the device loses HPB info. The host side
should also reset its HPB information, Otherwise, performance will
degrade. Of course, it depends on the specific implementation of the
vendor. If they don't report 02:HPB operations, this patch still
doesn't change the original behavior.


Kind regards,
Bean

