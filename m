Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D734C70E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiB1Plq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Feb 2022 10:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiB1Plm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:41:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9BC7EB15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:41:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-AFvCgAEnOC6V2d2xCYs19g-1; Mon, 28 Feb 2022 15:40:59 +0000
X-MC-Unique: AFvCgAEnOC6V2d2xCYs19g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 28 Feb 2022 15:40:56 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 28 Feb 2022 15:40:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
CC:     "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "quic_bbhatt@quicinc.com" <quic_bbhatt@quicinc.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "quic_vbadigan@quicinc.com" <quic_vbadigan@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_skananth@quicinc.com" <quic_skananth@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "elder@linaro.org" <elder@linaro.org>
Subject: RE: [PATCH v4 05/27] bus: mhi: Use bitfield operations for handling
 DWORDs of ring elements
Thread-Topic: [PATCH v4 05/27] bus: mhi: Use bitfield operations for handling
 DWORDs of ring elements
Thread-Index: AQHYLKD5KBrT0mkrcEuEmuVBLjzK3Kyo+w/ggAAO0ACAAAu88A==
Date:   Mon, 28 Feb 2022 15:40:56 +0000
Message-ID: <8433702975794b5389563393bf7bc405@AcuMS.aculab.com>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-6-manivannan.sadhasivam@linaro.org>
 <90b1d3954b8c4157a4045db82b562271@AcuMS.aculab.com>
 <20220228144336.GB12451@workstation>
In-Reply-To: <20220228144336.GB12451@workstation>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 'Manivannan Sadhasivam'
> Sent: 28 February 2022 14:44
> 
> On Mon, Feb 28, 2022 at 02:00:07PM +0000, David Laight wrote:
> > From: Manivannan Sadhasivam
> > > Sent: 28 February 2022 12:43
> > >
> > > Instead of using the hardcoded bits in DWORD definitions, let's use the
> > > bitfield operations to make it more clear how the DWORDs are structured.
> >
> > That all makes it as clear as mud.
> 
> It depends on how you see it ;)
> 
> For instance,
> 
> #define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> 
> vs
> 
> #define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
> 
> The later one makes it more obvious that the "type" field resides between bit 23
> and 16. Plus it avoids the extra masking.

No, (x >> 16) & 0xff is obviously bits 23 to 16.
I can guess or try to remember what FIELD_GET() and GENMASK() do
but it is really hard work.

Both lines are actually too long to read - especially given the
number of times they are repeated with very minor changes.

I actually wonder if you shouldn't just have a struct like:
struct mhi_cmd {
	__le64   address;
	__le16   len;
	u8       state;
	u8       vid;
	__le16   xxx; /* I can't see what this is */
	u8       chid;
	u8       cmd;
};

although you might need the odd anonymous union/struct
to get the overlays in.

Even using something like:
#define MAKE_WORD0(len, state, vid) (htole16(len) | state << 16 | vid << 16)
would make for easier reading.

Oh yes, there are some 64bit fields here.
So a 'word' is 64 bits, so a 'double word' would be 128 bits!

WTF is a DWORD anyway????
Are you going to start using DWORD_PTR as well ?????

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

