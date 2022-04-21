Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC950A041
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiDUNFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiDUNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:05:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A86338A7;
        Thu, 21 Apr 2022 06:02:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l7so9938601ejn.2;
        Thu, 21 Apr 2022 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=bZ9BRYh9Iptwg3pfiMWF/PamDeh/TgAduLIBmTdqTrM=;
        b=D2ngQWLeBkbQlmv0D7Ql413R4QSfNGi0WSjltKyjFD5UcGR82J8zXrQAQ9RYYkmnkU
         /pcDFRUeI3ewWM7mlIas0uD6qPZyQ2vLxd1Y1Qipi4yH4rG78nFwbDTolXkIsa8E5q3U
         I8uxh35sS6/lBEqds85XHKpPc8+wNPn1qnAl+USZcUA/n+rhqbb6X5PAoHhDSWtzBgIv
         PcSxCqe/M/w+dEYVRboPliSjOx9OzaLy3HbJ5+TtQJQ4cxop0sLyXX9A/n1zD2JW9S9K
         GDfvJWKfF+5Pw3sUJLHDdvjUlj2yX3RzyxkXcu5LVaSlXh3zJSlxq6h1Rp+5rfj8zuzN
         Y43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=bZ9BRYh9Iptwg3pfiMWF/PamDeh/TgAduLIBmTdqTrM=;
        b=G8JCMvcM76k3epVoPiogpBUOOX6HkPHIAmX+EWzdPxxRglUs8gqYSi2X018gt1YP/Y
         b3UxDAAL34GF/woNtx07JudI1C2vTmzVf4vaURolhdxzsiyBJHxIjcf8uiIXwlM9tGaY
         EZdRzJT42RKLHgGlJglrrq8qlqzCDbArwaljdZP2TukW1+JXECNV+vha9PUwXMxcTnp/
         z4wJtv5z7Ii/HgjKH2/ZmJJ/TYCzNGH+GXr/bqgaDYG9c6blpIHN7Lz/3B9zjwCO/nMF
         t7qSVzLWXey13X2AYmJSU/oXb0dRcWxiMnGTQmBQQaHcKf1jDeB8gytsfcXiM+PvZcEL
         JpkQ==
X-Gm-Message-State: AOAM533qAj89Tklx0+p2tPjCu8cxdkrsUGMwaz3sOshLCoHa+0JfRgox
        o1mXjR9juHhRh1WgwrVfOx8+NhNSgiEWXQ==
X-Google-Smtp-Source: ABdhPJxM3/fmxYqKDgtGwzuIThkGuP0R4Z1ufpvkh5Jx37bo4XkILkg0xor/oQCC98wMLWt6WcxiOw==
X-Received: by 2002:a17:906:7fda:b0:6ef:811b:e1b3 with SMTP id r26-20020a1709067fda00b006ef811be1b3mr20214494ejs.178.1650546144847;
        Thu, 21 Apr 2022 06:02:24 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id x8-20020a170906134800b006e86ff7db33sm6529105ejb.68.2022.04.21.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:02:24 -0700 (PDT)
Message-ID: <65d157227ed8a1f78eb7e309278ce05ec53328ee.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] scsi: ufshpb: Merge ufshpb_reset() and
 ufshpb_reset_host()
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, keosung.park@samsung.com,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Apr 2022 15:02:23 +0200
In-Reply-To: <f66f17bd-67a1-b888-01a6-4c1a02f1e21b@acm.org>
References: <20220419183044.789065-2-huobean@gmail.com>
         <20220419183044.789065-1-huobean@gmail.com>
         <CGME20220419183926epcas2p4f529c4cc6bed9ba4b6536f3a5977c3f2@epcms2p8>
         <1891546521.01650433981606.JavaMail.epsvc@epcpadp4>
         <db1551628c191c8efdc2e7bec1313c58636c995e.camel@gmail.com>
         <f66f17bd-67a1-b888-01a6-4c1a02f1e21b@acm.org>
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

On Wed, 2022-04-20 at 20:48 -0700, Bart Van Assche wrote:
> > > How about changing it to something like ufshpb_state_toggle()?
> > >=20
> > > Best Regards,
> > > Keoseong Park
> >=20
> > ufshpb_state_toggle() is much better, I will change it in the next
> > version. Thanks.
>=20
> How about ufshbp_toggle_state() such that the word order is correct?
>=20
> Thanks,
>=20
> Bart.
Sound good, I will change to this one. thanks.

Bean
