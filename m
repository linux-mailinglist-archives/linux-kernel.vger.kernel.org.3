Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59965535B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352623AbiFUPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352439AbiFUPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:16:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70101.outbound.protection.outlook.com [40.107.7.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D53BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej7YsNrmtB0X9tTiijH9houudq/Zfr5jt9pvI7Cuq4DVl+OHScykxgyTEmniyLDlOQSaL7MiXTDXeWw1Dv28YxlXwC/UN3jPfnCVfw+Mub6NfSaKRcwGa6BnkqjECW4XLsZPLsm01ls/kf1p6/e12OY5xtVqJyfSS85T8NRRHOwaAK8nv3QufC7xoIUKu1GItnUuMH3IWQC0U5w/m46xP6ZKnb/yOO7akcq3KlXgTFW7DedbPKN+tvl4LXwFyXGNjtBFBsQc0vOMQlgZeTHQ03nfDmVpWF2Nx+UF22PGwLYXOByS6vO37cYdo6cXWaRrp4j8BQOosHGo05yEvJ12Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5wmXOirwZbcAozrQJs/9ft/VeOsZEynWpV2Q77N1I8=;
 b=nUxssUHiEAH7TiiNZKOrGwHWZmpdNxf1cqg7b/JPAqmDC/Q5UUrPur7I2aqm0TTlOo5bFinbos9t+y/uFnna+AZIhQn8u2bWFNHYD3jRUDh6Vdnmvf/5aUuTBaJVpNOAPkx7q2WREOfGeaYXl12GPdRv39R+qjNkaSbS6Stst9IP7Bb9znR3+KVYJzC+IFEPkuY4767Qyp6lXcTuEz189KaoP96hfmT1dieNpTR8wuF2IIpTK88oATpMBv4z5CeRC5YA9lKN7E7jHCd26252T5TpMyzgvRYHy4RdbeEWDnTQlJZhsaS3Tm7qg4S81awNk0Jj78igPZmvNAsrRDNUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5wmXOirwZbcAozrQJs/9ft/VeOsZEynWpV2Q77N1I8=;
 b=oAk5/iNpJ+KAyv2eUpKs8udMTY+PwO1abWUuE2Vggexb8LmVPKJ8+4kCQ3+WKuBd8k1sz/zRTYo+J6rxjmV6e+rr/3GX7Hw4mE3mtopik93+toK6yKoRcFnxSiTb+WwWOBfduIfeKIul7fALkOZL/zUYXgkr4ZGkJ4/E+uiimhA=
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AM0PR09MB3428.eurprd09.prod.outlook.com (2603:10a6:208:174::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Tue, 21 Jun
 2022 15:16:40 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:16:39 +0000
From:   Joe Korty <Joe.Korty@concurrent-rt.com>
To:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@archiver.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RT BUG] Mismatched get_uid/free_uid usage in signals in some rts
 (2nd try)
Thread-Topic: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Thread-Index: AQHYhYCqPSRVaFiBokm36HtjI5/Zog==
Date:   Tue, 21 Jun 2022 15:16:39 +0000
Message-ID: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 57703a2b-6ad3-81ba-7656-6385ad05242c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d88620-f465-4e96-7264-08da53990a93
x-ms-traffictypediagnostic: AM0PR09MB3428:EE_
x-microsoft-antispam-prvs: <AM0PR09MB342806C023F14212C687BF31A0B39@AM0PR09MB3428.eurprd09.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATVjBaNsFvKvd1hK4luqFlXmtfEI76yHZWgl7WQqct0f4ItXiN0M/lZ8tLdCrKxxcHXGJn/i0HdF2bwq6mxNAORsOIw2b4vX1CpMK8iGTYASSigJ+3EcCI3hnw+2bB3eFUFRh23W/RMq9SDukLKXja+tlBtOtwgV7vPvztj885zEN+JDX6rd7oVtd69Tke5UlXAaBJ+pP2Zm3Y5ApmjPgUB3V//HcQzlA9QmPH8qNzyr0YOQ68HELy36hV5UqlC4yCFhDd9RLmZ+afQ29sjgFWzs2mnvuTeKNx66i47KVkdGo90/rcsslPWncw/jJI7j0s93IPQ7q2ACnbQAnK2Gqd/XHWg2+vc9/j8GYEM0VunJ2pUaiKrLTy2P1dk2uWe5LSvZ0pp23M1bWBnigwKB9plNbvygyVtOVuGKSUid8t9SqKbzcUD3JK2za0J4slTiS1uMTi0AC15fDEbXGkZnVttDFoS8m8G0HzvfkH1QWs1ma6tf10Nwa7FEO67UsOwqFrapVTd+T5lfnY2SCTMXEKyl5veQhY+CJv7x3BpQlwjXWWHhXrHba2dn+uudgBtwYAgNQRNpqw8tKXEhIiWEGiv2swHWXe/x35tcSeHybxAbtYjW6tjxi5PwLI/9P5JwrlvJx0wm/Kih37riGDm+OLCjfWYSaW1eW41BxGF0zVty2kjyHtkEwUqAL9G7QuzqtQ1N9s9lxwjGbfCwUewJjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(71200400001)(38070700005)(8936002)(6506007)(86362001)(91956017)(2906002)(52536014)(478600001)(122000001)(4326008)(66556008)(66476007)(5660300002)(26005)(186003)(55016003)(33656002)(45080400002)(316002)(9686003)(110136005)(38100700002)(8676002)(64756008)(7696005)(41300700001)(54906003)(83380400001)(66946007)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ek+ywkdInaHadtPiLzcUpiogXDIqZlRpwUoB9J6CFt+Im+OIXofrT81MAQ?=
 =?iso-8859-1?Q?wzHCComn/kgo34MUXi/o9zHoiYnT62M3+0nvyoUoIGbJI9kNjEZuHcwWXz?=
 =?iso-8859-1?Q?kF68Qjn50Y64smrKeQiVAAuZ+Ysuf9TJ//CD/LE+wiLTUYNQtWN2T5bSan?=
 =?iso-8859-1?Q?EiKKaRgw8TU2giALRT9K6GPN3P2otowUWkiC/kymc0+da84+QT+IWd+HlQ?=
 =?iso-8859-1?Q?5K7WT9tV6d2ywWLKlgcy6TuZsBJNMfO2pKHJxzyLf0mA1b+ina/PQh53h+?=
 =?iso-8859-1?Q?6/jp5smaUDKF88IR80FbMLQ5GnS8kcTnq3fdDGipBDobAiuqp/ze/15YBs?=
 =?iso-8859-1?Q?+hlWeY9Vmgn+vxDQ+Cx1oiT7n1ERmzvjwnzSQR+HyUAU6OvhpOciVHa+0q?=
 =?iso-8859-1?Q?pbNcIJY4vIdBNo0YJMdPF0iUdpTkEis8n+Frf7yqnxHu3TGENnfxPn07t0?=
 =?iso-8859-1?Q?UWWYqRX/Ahf3xIKtuyhV9zzcvsN9xr9xAGFiXc/R5/f8dqsI58YPb2PNbX?=
 =?iso-8859-1?Q?wlC4IOth3WaTaeyj3HZbJg0Q7aYWi2CZX0+Fzkd/sH0UNJey9+HbgQzobI?=
 =?iso-8859-1?Q?5Hbd2bXWr2Ul9Xp+Gi4jz/9LCdGRQydnJqeD2yS899Hh8Tfvx8LbbHNlN1?=
 =?iso-8859-1?Q?CMgGPTv+1Pp3vIXQLVg5JFOxgDjQTbOsfa4b0Bb2qRozME2MdtL79BsQcp?=
 =?iso-8859-1?Q?0ttQ0b0QrVs76Ktfy3hFWqpuHk2xCcZ9wCRuCZhuQK16GJTFoM0HN8I+No?=
 =?iso-8859-1?Q?tDzQgWX7kiPGoFUFBtxhRf1PUa3b4Ud8n1PFk5d7PlPH16Dp/VLE44h+u6?=
 =?iso-8859-1?Q?eVWL7pCsWyPbyrYHBYmDd8bz3xZfQqFupLNYsoznYmk7OdSw4GuEq0XtCF?=
 =?iso-8859-1?Q?DAZT20Kyt2/e7gHUiuC3pCHE1yQd/RH9uRyghBQujk+wpW8AlF/cJouwmx?=
 =?iso-8859-1?Q?gnN79UUC06zmN11qsqGJ+KajODTwH+FKbi8bmJ4D8Ab7XUO3EILzp3K5YF?=
 =?iso-8859-1?Q?G0ifid+0cTaf3MxVvDlewwzigwXJuMAJ1URPMdlT2TNb1NuCSIYdHFnKYo?=
 =?iso-8859-1?Q?TNrecd38lf2SZimIsUEdqBWCANeHuLcXFCEy9JEmoMraMtA40dsCC4kqik?=
 =?iso-8859-1?Q?qofa7tPovXcSLRcmQIJynZPtWGFT+v19Cmgonp1TlV85MaTRlBfU9VLoLh?=
 =?iso-8859-1?Q?vVIbKoCnlSAVdUHbPUwkpePpqk9xgmhvHnfsDk4TZyXTvOFT9A5q7ufxkk?=
 =?iso-8859-1?Q?GmazCQflkI6FjkifNdDrUHz2qr6xL2pQbmt29P2qBIvhGGrwRHwMQM1C94?=
 =?iso-8859-1?Q?zI2hx3MzUZ2y74FCc1ktcZLVnYi6P0XT6rz/Yw9TOlWFv1IPe0spdqW0Mw?=
 =?iso-8859-1?Q?XK2MIFfuMWTi45a9z1eLnsN6re6RO2gVEgC0vCq+9TXwuvhTfnB9Cq9a1v?=
 =?iso-8859-1?Q?l/46erD2/m+DacXCWiHn58kQiFX+iwq2ui9z7JVn1iqr/MRrM8m6Xn57Fi?=
 =?iso-8859-1?Q?qQ7g8+I+4rL1PYayEQAfu0yEd8UsCLpEeywiipMdjJCUYzTUt5nAdOENuv?=
 =?iso-8859-1?Q?cvNhjnVh3hLFuFo2xEVlg2oouBoqRSbO2sUtlPE0sQ/TIztU20pkBbMav3?=
 =?iso-8859-1?Q?FQO9oOfBW8de18s79zqW2Mx0AwE4I7CWPj3HPYE7PFsmIcVx3rD0iZcNZY?=
 =?iso-8859-1?Q?aJDfNJt/P7xTjfegSqU1FmzXtv2QxqF+YAtHTiC5E2KR/KEWUo3CJFjUAT?=
 =?iso-8859-1?Q?T7HxsBKQA35Cs/7YF5onmB/GxXdxwelTFU7OtrbCray/F2nS8U5qtBBcsr?=
 =?iso-8859-1?Q?pqa3zjda4g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d88620-f465-4e96-7264-08da53990a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:16:39.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkXcn4ppd2Cng7jlqTax88fGCEyOFWiM8xS01bJgnl0G3ibiKUU51qp03XYH3QlrkFNaHddlGrQYJ3ryOem7vcW6yRnMwWEkZUdiKKep3QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3428
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mismatched get_uid/free_uid usage in signals in 4.9.312-rt193=0A=
=0A=
     [  First attempt using mutt did not show up on the mailing lists.=0A=
        Trying again with office365 Outlook.   Also added the 4.9-rt=0A=
        maintainers. ]=0A=
=0A=
The 4.19-rt patch,=0A=
=0A=
   0329-signal-Prevent-double-free-of-user-struct.patch=0A=
=0A=
needs to be ported to LAG 4.9-rt, as that release now has the Linus commit,=
=0A=
=0A=
   fda31c50292a ("signal: avoid double atomic counter increments for user a=
ccounting")=0A=
=0A=
which breaks the longstanding rt patch,=0A=
=0A=
   0259-signals-Allow-rt-tasks-to-cache-one-sigqueue-struct.patch=0A=
=0A=
Current application status:=0A=
=0A=
   4.4.302-rt232        OK      has both Linus's patch and the fix needed f=
or rt.=0A=
   4.9.312-rt193        BROKE   has Linus's patch but not the fix.=0A=
   4.14.87-rt50         OK      does NOT have either Linus's patch nor its =
rt fix.=0A=
   4.19.246-rt110       OK      has both Linus's patch and the fix needed f=
or rt.=0A=
   5.4.193-rt74         OK	has both Linus's patch and the fix needed for rt=
.=0A=
   5.10.120-rt70        OK	has both Linus's patch and the fix needed for rt=
.=0A=
   5.15.44-rt46         UNKNOWN no get_uid/free_uid usage in kernel/signal.=
c anymore.=0A=
=0A=
Regards,=0A=
Joe=0A=
