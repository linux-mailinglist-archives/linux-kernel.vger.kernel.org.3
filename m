Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E556BAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiGHNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:32:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DD2CDD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:32:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e7so1673521qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Yu8bKYHlHx+dbL+sw5q4ZRjn4fcee2CGtMmXinJvd+o=;
        b=lY7hu066xUzcIPr5UD259wVv9tm24Aiv8xv3EQDHIa7pTX8DiAkoXNDgAydq0rTAU9
         Cz9TuaHrjf2ikc6wmyiA9loansNDWN21rEMN6Ui+IvKWmhdNuGb9HiuiqoL5flj5/hso
         CwgngzRxtPC6wfCBamtm6LzR9nxj5sqqw/4RtcV7461qSGIMGBeqnPw/DF4F1Av9eIRf
         cqQ9356+V7IVsFw8iB7db4Q3WiOGoottS7uPymvy6FluV1b16WCV/zaWqBsM89d9dAEi
         kjm1A5sS0LJA5yAQKngHzyVh6k2Wr0pxiP3bLeQ7OowW5O1keZEn6H+COK6Wfp22Fapc
         ogHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Yu8bKYHlHx+dbL+sw5q4ZRjn4fcee2CGtMmXinJvd+o=;
        b=fQCl81q+f2VieW8Tcttsz8Ra9Nbr8lrlCmhmDyY1CZHcMbj8uAy5MND8vcn4f15/vW
         ncqcth7ZMJOE0s1BZtW1R9lfi3ilQwoASEsLt1D3YtwCtE129tKAo48hYGQaiAS0H+1n
         wUA21ZuMTLfAPA7SNkI3hUoJoFQVJjd+IOPVzfXzms8q+dFJzDGEpc0SQNLGxzEHzlbQ
         eJryMItXWNKalpoWP674V+a4ZS64tt+Wm3lCxKr47IEhROwRXMyYoY+wfTwYUhHXByG/
         KTrDlaboMYxf4Z4hxm2fLE268LLzPrOEEK3jaJYOLEuFeV0H/tZeKArLJTBa8hignWKH
         QunQ==
X-Gm-Message-State: AJIora+ZpCR3MNUf0srkyycgoDuWvHpXG033TKHB+ekB0QhpIhUzkUt/
        UegGpXMdtxzq5lcXPfGYQZ4YHw==
X-Google-Smtp-Source: AGRyM1uyuIWyl91hCY2bh60iyU9jBQdwPs2f+kbRSM+PSbqNROmEadcwNKqkO4tizj21zxRlydHeVw==
X-Received: by 2002:a05:6214:1c89:b0:46e:4048:ca2c with SMTP id ib9-20020a0562141c8900b0046e4048ca2cmr2703474qvb.60.1657287142094;
        Fri, 08 Jul 2022 06:32:22 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a401000b006a6a7b4e7besm39100667qko.109.2022.07.08.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:32:21 -0700 (PDT)
Message-ID: <2f35d8250ce133e21eb3987977a92af583e32d0d.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] media: amphion: only insert the first
 sequence startcode for vc1l format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 08 Jul 2022 09:32:20 -0400
In-Reply-To: <AM6PR04MB63416B4BA53E80123037AC8EE7809@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
         <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
         <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB634136824EC98EE804FAD0CEE7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <42ba6a9516f4359b757d2f94b16c1bb23cc41cb2.camel@ndufresne.ca>
         <AM6PR04MB63416B4BA53E80123037AC8EE7809@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 06 juillet 2022 =C3=A0 04:09 +0000, Ming Qian a =C3=A9crit=C2=
=A0:
> > Can't you save the slow copy by using data_offset then ? I think most o=
f the
> > confusion comes from this commit message, someone else then you should =
be
> > able to understand what it means.
>=20
> I'll modify the commit message that remove the unrelated vp8 description.
> And unfortunately the amphion vpu only support the ring buffer mode, so
> copying is inevitable.

Great thanks, I had forgotten that Amphion was based on a ring buffer. Inde=
ed,
this is the way to go, same applied to CODA driver.

Nicolas

