Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2489C4CBC32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiCCLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCCLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:08:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293745AC9;
        Thu,  3 Mar 2022 03:07:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvHB0aQiGpRa7Vzxqidat6/yYSp0N3dbyoPuFV027o1PoBAq61lN1MIMFeUVZbkZ4jdm2kwiH84E09HaPBmWnONeZc6CmT6YHQQMrW6PTqHK7k4W6BxEa93sQ3oBdbOEdBDir9OzWvPDzeJb2tXuoG+AnxQSv7vX2Jf/FJVhvhC77cMKV+Eh/XWyKYTDlnufia8KuY8avpaFOZ7/3NCep+/ht9jibmbQ9fNrD7OjqE3aj56vyMXziQRih1Q2zszURbwmrOrS55QT1QPGRnOfYh0dMN2IlKW6du9sZz5nUU5+Yu6C4Qywo+RwqPH0Irtq92GQFqVzpE4D9h/lk0KF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfLpFcR/pOAJf5te7rxDHn5jQuygScoizxUfT/aKgO4=;
 b=MmYQUipCyhh7/hJ0S+fOfiIdAJRcoFVCQTR1ycD3yDDfhyHCi6ztjHA0EBh9vWQOikXaUn/4eyJM/YXWs56NSX+lUf8kLRjr0TqNwbaaFTTyqTQiTj0WFKwyQA4S667ThUsBxjs6vbAp7ZTpaHLh1Eamlks8Ptziv7qiMOE8ipGVOjG+h3o4OybdMnj35X4PSNf/NiULBdtxqCWoHjCj4d5pRBmN/lQFbGOE1mHoywLZtr+VK0kRHZzQi7PRlDwa4B0rrBQ3ued74ItbqKXoWvsPWcXQz6FX4mlHgLbDsU9aeU3C+7HZ6UbjwFZalNEin/bQFryUZ0GkNA8GAINu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfLpFcR/pOAJf5te7rxDHn5jQuygScoizxUfT/aKgO4=;
 b=G0/gujuqZLAfkarLpZxsD8g8y2RJjXspMhjB4WD9Ms2EckIwscYn7b3LPjTch0xpQGWtCLWk6oeeL/X/BKK21eQC4RwRGwtinVKHHPyNPrWcTJshRbRXyr7shRWoAWg+8nrxyf+0jDbgGR/pqjm2hA9PeUnbyucCSGtlXDO+NFg=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by PH0PR02MB7431.namprd02.prod.outlook.com (2603:10b6:510:1b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 11:07:54 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 11:07:54 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ACPI flow for reserved memory
Thread-Topic: ACPI flow for reserved memory
Thread-Index: Adgu7qDYr4zWEDY/QFyl4NmYFWdP8w==
Date:   Thu, 3 Mar 2022 11:07:54 +0000
Message-ID: <BY5PR02MB6947E939600E244DDDCFF341A5049@BY5PR02MB6947.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df0c4067-9766-4cd3-63c1-08d9fd06110f
x-ms-traffictypediagnostic: PH0PR02MB7431:EE_
x-microsoft-antispam-prvs: <PH0PR02MB74315C9C5F1E5303180E5936A5049@PH0PR02MB7431.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8cvvyS6QxP6fyci/1xEcTT0yorN8h7ZohtvHUZz7eoq1HJ2ABldlD5IHiLQEJkHsDh9KN0hxph9FLEzwjqZSVPx8JUDzOry4VLYJ9c/kz21ojxz8zMx4Sz+MxRTcbQHzkg5XxQX/yF09E26rFcMousjKLU2GPjj3nMVkuW9eJKTle6Pxsp3kAuK8xe8P8wDiTQo8L1yorGmYkIesTCgWsD19nUIAo/3Xsrrkrp+7Sw9Sm9AFG0MGYIWGnSijNfbhkHnaixakOzh2SLS9S16PBUe4y3D/5Zyw5LwB1fcljEvsYoZgl8CLh7hUXe9gdD0Ekp5K4Xj0PL293peuem88s3Xu+oo/N+ufIYfLF6L6oXeyuZgxmf425Q4Gb7qQ67PrCY4CniXQeZeCbvkoLG65iTJ6AaW2iIWDKkHv9UnvOhVMMwjQfOLXXYrE7Oy5vQe/KD17Bp6xw+YmrpfiT8RdVJt5KKvnCUe+Qg3mbHnIP5ptSSdNCjcF6EeSYtvWD9/+G82u/M6UTn6YOjGEDUXys43eXDuWs7uMrFp7LgN1tEoiCPxGBvEJBTFEQxE2fFF0fx731+9aowjH9avnXFjkdblQA0ono4bZBU0NuRsjc8Au+X7R4naXIZelVe5rnicMr4OvTIQXTUUIG5fs1kZe+g13w7phV2syA6OCSXZpLYpxZTeZePaJ25sF20M9hfR+Lg8nvgi+fVDLd70MoUO5zamk2KQ857JspvaqR7xX4A4Tv6GxeLn3wjvHcU83KMbnAkSYBD/cZOlYqhB3Lj7lvUUSu+gzFhmCKRFszJuubc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(33656002)(558084003)(6916009)(71200400001)(66446008)(64756008)(66556008)(8676002)(66476007)(76116006)(450100002)(66946007)(86362001)(4326008)(186003)(9686003)(26005)(122000001)(38100700002)(55016003)(2906002)(7696005)(6506007)(52536014)(38070700005)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7xfH7qTQIWdYze5H0nVF5QWYE3/ol/sLCmy0FYIFnQITM58/swL/fjgmOjqN?=
 =?us-ascii?Q?xus3hywVeGG2cxtaDGkdr5qIZZ84/n7SeLIDQm84lPD4102Ql3VqAgsR/y5e?=
 =?us-ascii?Q?jC6id9cD0L7P5e13+bWqqcTcWnxJPjTDT4RRlRcu20X9cdPl+3xGVJK9c+Vg?=
 =?us-ascii?Q?RqCTAjEMHYCpif6r5JNsyWJESk7ddBK42AVlniuoqS22+nZmntqL0/wPyERD?=
 =?us-ascii?Q?mOVEKivjVemicvfgBfLSFypicwhQzGNnmIEhsDoJ/7R71nDJTWgH2ghUQS9c?=
 =?us-ascii?Q?0lskedgT4e4Ehk7i3eS35Wixi7m7FmWCYo3/WIREkv1yKASScwqtAUgRjNCs?=
 =?us-ascii?Q?+o6cPRcWn1i5STG34yfnjTd4mNFPPHnhVTVNUe+hm9t8qSEwe+KhvbQk6lRN?=
 =?us-ascii?Q?dajMQzHrbN0ZX014gtdKWb/qiiSVQ/FX0WZ1hEHmbV+YDIHkZ55lY5Bo1Le7?=
 =?us-ascii?Q?zQE8FdacdGT3Y58jSIGb0dATmNFH243U1T4JDpqlyOw8Qzvwx3efFQwo7sxm?=
 =?us-ascii?Q?S118wlVfK4+hLwW5jKO7X38OwrifCoTkMrKwGA/S8CEfslxtHdkfsBQWR3ZB?=
 =?us-ascii?Q?oqkNjNvdfEoxFT2dD3glJSof8CCTPGQU/POwQi2TecCsfhfBhJ+OWEDZ+IZR?=
 =?us-ascii?Q?NoybQ8Q6Q9lH3mGRcI6q70VIBxZdF+EUanUKh+Sr4IhOgidiyEh9YQ9IBp12?=
 =?us-ascii?Q?6sEU9L7DaKdQtBf5Cm5SudcZ63nac6YUc+QHyl2WzbaGhQSJOilgp96HUVVC?=
 =?us-ascii?Q?ymhh79e0AJX6qXOsXtFofXPpXJJbcJDclFrEeVRhrwbTFA2N7QjYjOWQ4eW/?=
 =?us-ascii?Q?3Lu3yP4MFwDyBPSYubMj6M5TTCDeYQiDLRrk7PcUix2ZL51h/2Ll1mmsDmlY?=
 =?us-ascii?Q?2S/eFlBd3+Pq4dU1ygymDoEtHM9IOxxLZ0Yz14dAZdYDxzogDyCqHt9z9YCa?=
 =?us-ascii?Q?DpmJGSWZEUq776YcbEKI71FlkadFfHo+EWCklLpVJsyJXOW2aHJZsVCO6LVu?=
 =?us-ascii?Q?3ewdV+8rCYIKEB9q1wxMjtd5yL6nNg0UfemPRiuDPWYrbgas9d5fwQyZJikA?=
 =?us-ascii?Q?rOpWA3NZ6NIo7aDgp63dZ0IF26V1qUyrw6lE+UdO82/0O6JnKz3NOfowx8qI?=
 =?us-ascii?Q?U5WS8pjN/9ezN6ecmoeb19rqsEVbtyeLZicNU9H7O4zTXOJtHkQeGN/8ro+H?=
 =?us-ascii?Q?/c5kWZwis3Rg1frgILquKNMopbwatsEvI0CSuwkfpXR4OdKh3TMSkLYIKy+9?=
 =?us-ascii?Q?xZNUGKzTH6xIgofEwkBqedE4s5EeSLR+fARKZyOwvAoSlD/BYMM9/M6nKrt5?=
 =?us-ascii?Q?IRlggXFW6d99J7NpgkeAaBBM3hrtUCvJJL9FtWVrN+Ert3gmUjAdtm1XwRn0?=
 =?us-ascii?Q?rInAlTsotEOh82oYGvqRmBB7HTksduW7WziW7YzQ2mZcYJcO2tXe7cvy2vte?=
 =?us-ascii?Q?+IlTIkbr8eK4/IzjgIHHzk5/YEc1yhjK3WQsPUJXyLYj9DMKuNFxqcTN6SJK?=
 =?us-ascii?Q?y1LsLlh/YzHBJTrTGAqSrzEGeEPkJqQKCCChchFe65nl6Lxee4RHH01bFNOw?=
 =?us-ascii?Q?5ef78KCh6fYnSh6HFjKD4XxBmZjn8xunQXY8Hn0iqKBZoBsjSvT214yYq0WW?=
 =?us-ascii?Q?Wm/wxiLS+jDuoKN3Fxg7cEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0c4067-9766-4cd3-63c1-08d9fd06110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 11:07:54.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JvdxxwOrDpfjZBq/j9F/zD1mhDkg2mmnvxlKH8EML1vda+oFxt7l2Rdoc8OX5MPEmGiUGjU8wcDFbivB2u+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7431
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In device tree we have several ways to=20
reserve memory (https://github.com/Xilinx/linux-xlnx/blob/master/Documentat=
ion/devicetree/bindings/reserved-memory/reserved-memory.txt).  =20

Can anyone please help equivalent flow for ACPI.

Regards,
Bharat
