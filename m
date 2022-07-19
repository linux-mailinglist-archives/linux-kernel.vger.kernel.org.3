Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934957A44C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiGSQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGSQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:47:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261457256;
        Tue, 19 Jul 2022 09:47:38 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RIbHs8Gl+GPLeVPCnPnrQT2xhM4dgWFo0IXwrQ6Z1MKfvyJ0NfWhhQtzPHZIIV7NHG88vJbv3/qg0cnv8DdrDCiNq++fLccrmhI06CF6tQEbz2pJzdMsD/08j5DX6PJMvODxfwEIpkwMbfr6X6qH+LGhYFG9GODMHD9PNnm3QItTxQ4xwCUOp5QGfKpIi28dGpMQV6IRiK04va00rVY+NEtpIp+Mu4p4PzNfgUzp/4yl1ZtLb7DuiNq38EjQooaDAM1SFZS6YKz2we9eDG5xWQRiIv1PUs+sr9sCLo9jUqMZiz0LYXapL8qZ2wjNvcyeBO3IrTKVycNEOxNwMzR3sA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIvNyLeLvq+jc9tdeQoHvZ8rE4PFyAsy15LWNjOUWOQ=;
 b=IRY/nayCg9+JRH+J6ni2xIKBOR5wo9QYWUD2vGjwYDXHSQLW1N+xMug1ll7fx26EEpAeGiwRgoUvmuMyOBleddWlnl6tzqTLEXsYV/siRbVWJXJlKlhsrQsrpWEHEGkDzCCrGzQ4jm207eb2P4mQGggdnlMpM2w6PdBZpONBjHa9BfswonVmfeUyn54H2nZnTb8MWwvVXgeI08+/zJJlZb4i0I+RnaadM4pCNq7WnFdQKTlueVOcOXowhZXcn2mgjWWtlDS+wI0XRsHXLX+BW6+d6GUYmccvjlYnzv47gU9gGyp8jgpId27wcrZOtPWqHLibuIwqDSlot0XSt35+8w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIvNyLeLvq+jc9tdeQoHvZ8rE4PFyAsy15LWNjOUWOQ=;
 b=MwApUTTbUzj7uW9OOu0z6w7EPPpkRUpmxn5DrGe/s0TqJNvpE74QfjvGue9W1E7DF77/935FZCFo++iuCdtMZKdYLAfuaDvZV0dT9IH3CSEe3ZTqdFabhcUUZR1mLHbQ2hHe1Bhb2L/E2lxcZ+2LUa40nq6QZIVCrQ5DTu73aRw=
Received: from DB8PR03CA0010.eurprd03.prod.outlook.com (2603:10a6:10:be::23)
 by AM0PR08MB4276.eurprd08.prod.outlook.com (2603:10a6:208:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 16:44:39 +0000
Received: from DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::28) by DB8PR03CA0010.outlook.office365.com
 (2603:10a6:10:be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 19 Jul 2022 16:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT048.mail.protection.outlook.com (100.127.142.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 16:44:38 +0000
Received: ("Tessian outbound fccf984e7173:v123"); Tue, 19 Jul 2022 16:44:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 34891c7c5cc7b5db
X-CR-MTA-TID: 64aa7808
Received: from cd9c0aa3d587.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 120DE3E7-9CED-42D8-8A9B-E624A1254385.1;
        Tue, 19 Jul 2022 16:44:32 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd9c0aa3d587.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 19 Jul 2022 16:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1ZGZyD1fDgrnXczCVkEpWsH2RkCGVEYmPO5kHDuUDBqtHZwUJLfv9NVKxZPhAD9wDijPlPy8jg24X5Oq1ofpre195xSlPHuZXAgsI2Tb8oddAYNGA89f0TEj/lLpDXuaxDmc865U8YD6HE52b91ZI0931+AoDi+x3Ag0ouX0znEJH6SXzVgIL4q3gMx9E+9dbYOXDgLbmOBx6lgJqCTw5fGreZ6SO6KmKMbHxeHINDJya+SzL4WbRDGG2Mj/UNvpVQepkmYiTFE7ij/Pj4qw6f5PkcLtUf/H/YwlpG4s1czUfokJ/WdXRqdUBqZqEOfu0PM9/pal0qrhQ0zfreQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIvNyLeLvq+jc9tdeQoHvZ8rE4PFyAsy15LWNjOUWOQ=;
 b=a3zLEe+HkL5vvu/wtgWeFL9yrocYuGhiAnoAYNI7GpUV4pELPRFHceNi1Q6x07PDgIv06CkF6WdI8b267/UGRKqhj82I11q5UvVFnY6mkvsh5lgPQTzX0aXydKYzr1+Ns8p5C++BeXJ5tm2EHXe87ctXI5MRWqQFLTNQMBK20GppbCKCdW6ITYMGU9y0cTPeWIHd5rtX/5NrHnG0F8Dh5ZzW+ck7+4Eppatp4MUYq/igQsV+Vz8BJAQfN4SmX4AdYNbQvOO/GHRgoiYMCqZ0G4lZ2OlN+eOPk/HTka9FkRY8zmDqJ8KVpVobLYYzduaOPlcF7hXPfhVGKq5mdRmvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIvNyLeLvq+jc9tdeQoHvZ8rE4PFyAsy15LWNjOUWOQ=;
 b=MwApUTTbUzj7uW9OOu0z6w7EPPpkRUpmxn5DrGe/s0TqJNvpE74QfjvGue9W1E7DF77/935FZCFo++iuCdtMZKdYLAfuaDvZV0dT9IH3CSEe3ZTqdFabhcUUZR1mLHbQ2hHe1Bhb2L/E2lxcZ+2LUa40nq6QZIVCrQ5DTu73aRw=
Received: from DU2PR08MB7288.eurprd08.prod.outlook.com (2603:10a6:10:2d7::6)
 by AM5PR0801MB1889.eurprd08.prod.outlook.com (2603:10a6:203:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 16:44:29 +0000
Received: from DU2PR08MB7288.eurprd08.prod.outlook.com
 ([fe80::f5ba:91ab:fa9e:adfe]) by DU2PR08MB7288.eurprd08.prod.outlook.com
 ([fe80::f5ba:91ab:fa9e:adfe%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 16:44:29 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiangshan Yi <13667453960@163.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/lzo/lzo1x_compress.c: replace ternary operator with
 min() and min_t()
Thread-Topic: [PATCH] lib/lzo/lzo1x_compress.c: replace ternary operator with
 min() and min_t()
Thread-Index: AQHYl4dU7OhNaFTlo0aSr5B1g5/Awa2F7aVR
Date:   Tue, 19 Jul 2022 16:44:29 +0000
Message-ID: <DU2PR08MB72880F614EC5AA0B580E2E358F8F9@DU2PR08MB7288.eurprd08.prod.outlook.com>
References: <20220714015441.1313036-1-13667453960@163.com>
 <87bktr24pp.fsf@meer.lwn.net>
In-Reply-To: <87bktr24pp.fsf@meer.lwn.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: e9845caf-c3be-4229-d1df-08da69a5f8be
x-ms-traffictypediagnostic: AM5PR0801MB1889:EE_|DBAEUR03FT048:EE_|AM0PR08MB4276:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3wEuebXHgtt5RiTzVBHQjdqM6AchKCbekXOrq1qevkgipWEKQlvmBCPXoEnWUWU5pooO14r+nIFP9H/Gw0/w0ANYhcneLqqosnqW+K7ihwqpXzB1S1hsjaHujWWIAOYC7VwQOLDiogE0QlOSdMfjqB1z2sp7GYylwK6jAhFCvo96l2UUi5qQXTAj+i6WOcn0M8lrqJMfFwh5Z4akOeqN2rW8EbVloTHTAFfV+zAokLD2sTYiuZHWxSthMVcBRSbzg8xgxN7T6ZBmuCCIFGDqvkzLfhb6ha3m9T+IBmVQlXRkdI8VHsouOAGPBx8hPRpRCJSS53C4wRELxMWx8rHRIiTEfOJV3cWLgp/pKp+u0JpPkho1jEIUAX68LpuLWxqJ5mDeUjmshrCrxJuC07FPXsueePHGFcQ5I/oZEfwIX8+6/8zv+1LOlmMCVHi71Z2eRuUKtXPbpcwlH3YNcxabDCQnZGOSldSpyBmUyjnHfIW6TEo/L7niv3iw9jqlb4xlywOqIYx91qJJADMvnvoTPXjhnJHpbrrBG4IlY35aZ6DBSfrGqJPo6KQE/I6SKQ2VlqeOEMDZ6ZrMv4nmM438FmZ4o9t8bVha2vazMEMNonp4qHeYTMf8O3AVvzig5+3c1zLZVcXSy6GhEx9WL8Z+Q5lAIAv6ouW2yy669VnZZ7BStyHl49U5C7xmRXyTE9zzb68gR1KRlC1Ij1IUyz+qtS3jUMAiZuAVQdY80Xy5XJbUW/u41BlCtDFh8keV349xn687zN1HBFx/j9LIx9fb0xVVDihijfCGkqn+SomQBO0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR08MB7288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(83380400001)(478600001)(71200400001)(38070700005)(186003)(38100700002)(110136005)(7696005)(91956017)(41300700001)(316002)(53546011)(66476007)(76116006)(44832011)(66556008)(4326008)(8936002)(52536014)(66946007)(64756008)(66446008)(5660300002)(55016003)(2906002)(6506007)(8676002)(122000001)(86362001)(54906003)(33656002)(9686003)(26005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1889
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 903a809b-cf60-4099-5335-08da69a5f2fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jUXFypN1Nqj7fMvh5zqTYxRE5tDgBhT4pBYaMyAtamDCSGcCXDgXMWKCwJ9HRh/Ym3i5rYgaWR8TtKUqrP/kli4Tj5NE6iJczeAkcjv37q5ocs6W6AAAVyPJ8PNJNEjTiu8ItXA8I4V1TddY97AwvAqzomu1CV1blMYXocym3mO32T5sMFFwc44Aqw/lXNwfDjZcmrnGBNrqYRrve8isHRo1gnmB/pZJdATAy/RTYvtiHq+YJhzjLa510HZUeOw2Lo8J49vCocXFtz0K5VlCOa4E4v3WOaE/uU453MiTEzvCz33IDSRQUkTZnG33Ok65lJzHx9jSsYzIajj1+ArwrkRAyq2eNWbA6lR98Uq/DRHO+m/OWR4OxbJakoheYLLXVA68qLStLgXbyARVAr2bgQB4SlF3wFFk1BNbTlciOoPSWuopZJnaqvZogIk+Heuqe+n2/PE1/3cjsWEiyhMM4QkCidgnF9FRyHUfuyeqnsdj4Srs3k43uQCUSmHqgl6Ax6+fD2lJbXLT2WI68IK1hvqPm1QhAr+dLCnAgGUToE/hB07BxHMqeQTs4+PL9HLD3hngaszs8N/4O1x54ph1VTFU2tWfRIaVVY2MWUJHJNiOPy6Ex3Lvc+dnWMnIXNYDKaB998zfTTNniQPYIUnYiK4Ecj7/f9sX+7mERNF3lcwhPUTySIfvzhvp0jCSDh69XP0mnCEHhaw79WpGLpV7x0aeLRukPdyO5yoSXxLq9AS/Jz+AEV129I/IM/MK6WDEKccQCz2E1ObQUsGuoCXv7OpDKUGPmu9rxnl5QyNfeAzG+LRy6ML8iKpDyVS/k59
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(33656002)(55016003)(450100002)(4326008)(54906003)(52536014)(316002)(44832011)(86362001)(478600001)(8936002)(53546011)(110136005)(41300700001)(6506007)(40480700001)(8676002)(7696005)(356005)(83380400001)(70206006)(70586007)(40460700003)(82740400003)(186003)(2906002)(107886003)(5660300002)(81166007)(336012)(47076005)(82310400005)(26005)(36860700001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 16:44:38.9965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9845caf-c3be-4229-d1df-08da69a5f8be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4276
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jonathan Corbet <corbet@lwn.net>
> Sent: 14 July 2022 14:39
> To: Jiangshan Yi
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Jiangshan Yi=
; Andrew Morton
> Subject: Re: [PATCH] lib/lzo/lzo1x_compress.c: replace ternary operator w=
ith min() and min_t()
>
> Jiangshan Yi <13667453960@163.com> writes:
>
> > From: Jiangshan Yi <yijiangshan@kylinos.cn>
> >
> > Fix the following coccicheck warning:
> >
> > lib/lzo/lzo1x_compress.c:54: WARNING opportunity for min().
> > lib/lzo/lzo1x_compress.c:329: WARNING opportunity for min().
> >
> > min() and min_t() macro is defined in include/linux/minmax.h. It avoids
> > multiple evaluations of the arguments when non-constant and performs
> > strict type-checking.
> >
> > Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> > ---
> >  lib/lzo/lzo1x_compress.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> > index 76758e9296ba..9d31e7126606 100644
> > --- a/lib/lzo/lzo1x_compress.c
> > +++ b/lib/lzo/lzo1x_compress.c
> > @@ -50,9 +50,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t i=
n_len,
> >
> >               if (dv =3D=3D 0 && bitstream_version) {
> >                       const unsigned char *ir =3D ip + 4;
> > -                     const unsigned char *limit =3D ip_end
> > -                             < (ip + MAX_ZERO_RUN_LENGTH + 1)
> > -                             ? ip_end : ip + MAX_ZERO_RUN_LENGTH + 1;
> > +                     const unsigned char *limit =3D min(ip_end, ip + M=
AX_ZERO_RUN_LENGTH + 1);
> >  #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && >       defined=
(LZO_FAST_64BIT_MEMORY_ACCESS)
> >                       u64 dv64;
> > @@ -326,7 +324,7 @@ static int lzogeneric1x_1_compress(const unsigned c=
har *in, size_t in_len,
> >       data_start =3D op;
> >
> >       while (l > 20) {
> > -             size_t ll =3D l <=3D (m4_max_offset + 1) ? l : (m4_max_of=
fset + 1);
> > +             size_t ll =3D min_t(size_t, l, m4_max_offset + 1);
> >               uintptr_t ll_end =3D (uintptr_t) ip + ll;
> >               if ((ll_end + ((t + ll) >> 5)) <=3D ll_end)
> >                       break;
>
> So these look like good changes to me, but I am not the maintainer of
> this code.  Maybe Andrew (copied) would have a spot for this patch?
>
> Thanks,
>
> jon

This looks good to me. I've given it a quick test and it appears to functio=
n properly.

Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
