Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E54BEA15
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiBUR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:59:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiBUR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:56:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B605E021;
        Mon, 21 Feb 2022 09:50:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21L7tWjm002216;
        Mon, 21 Feb 2022 11:50:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=PODMain02222019; bh=DnGKY4K9+L3pccNfwIlhl6v+fqvbpFmhsVI/YK45NYo=;
 b=T9EqJLkqgcJz5SGJ0MqVfMBcPoCn56FklhbjXaDxJg0IztbOqTN2fWorZ5acAbyeDyr/
 LAxQ/Gjq10yAwKUAIN/HeGhjk1f/teKqZCA/PoJ6sR1rAz075n5DMUZOWSAiZUTHyDZ7
 NmzJjcEHSJJIbXUP0C/SZeXN7E69aao/OyWTZ3rsNfq3o+IjEb3d+VsvsvWLezV6vemL
 2zwlsSi3SlHnHNDMGPU65nbwaTvTmxd6p+bKj9nBfpnF0+7WHrPjJo3KDgyaWG4U6SUn
 S30T8iYB8JyDmrEUP04VfFd9cwOMlvZcn0CzUFJXrCHXKv7WQSdAxUgYL0HKm9ddb8Qo xw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ec53h8q95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Feb 2022 11:50:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 17:50:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 21 Feb 2022 17:50:37 +0000
Received: from smtpclient.apple (unknown [141.131.78.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B6E4211DA;
        Mon, 21 Feb 2022 17:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RESEND v2 1/2] power: supply: Introduces bypass charging
 property
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20220212034400.kg4cy2t6g7espy6n@mercury.elektranox.org>
Date:   Mon, 21 Feb 2022 11:50:35 -0600
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Content-Transfer-Encoding: quoted-printable
Message-ID: <FF4489C8-87D4-42CB-A347-1DF55A68A2AE@opensource.cirrus.com>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
 <20220210154108.641369-2-rriveram@opensource.cirrus.com>
 <20220211204309.apzep7w233vh7iin@mercury.elektranox.org>
 <7DD3FE07-445C-47BC-92AB-B281ABF67068@opensource.cirrus.com>
 <20220212034400.kg4cy2t6g7espy6n@mercury.elektranox.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Proofpoint-ORIG-GUID: CkuJgU-8jrPo6FpL6eS3qG1e62-H6xbw
X-Proofpoint-GUID: CkuJgU-8jrPo6FpL6eS3qG1e62-H6xbw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Feb 11, 2022, at 9:44 PM, Sebastian Reichel =
<sebastian.reichel@collabora.com> wrote:
>=20
> Hi,
>=20
> On Fri, Feb 11, 2022 at 03:46:52PM -0600, Rivera-Matos, Ricardo wrote:
>>> I think your patch description is a good explanation for that file.
>>> Also I obviously missed to point this out for the "Long Life" charge
>>> type, so please also add a sentence for that so that the property
>>> is properly documented.
>>=20
>> As I understand it =E2=80=9CLong Life=E2=80=9D means the charger =
reduces its
>> charging rate in order to prolong the battery health.
>>=20
>> Is this a fit explanation?
>=20
> Yes, thanks for taking care of it.

Ack.
>=20
> -- Sebastian

Ricardo

