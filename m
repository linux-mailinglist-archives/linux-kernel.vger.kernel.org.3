Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AB5A0C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiHYJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiHYJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:18:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875CA9C30
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmZCFrcC4uI3//sVvPJt8ffExM4iBL76NANYviRWFcqzdtF44myT4iGf08cHZPHSj3TSViie9mYZgSEjVJovT/YmNeHCax2LWIDnabZxiQILLmcfuKuPLaw1nQS4KDcNswbLo0NJin8MIfW7y7uVENL4dTNenDaosWpecA//Ue8bJTQIUoS1K9gcrNuK7XRgJnQNKaAZrSCBly1yctPfxhlcBUXzlD0tUF8e/h7Z+ykHCoGkExaDb22vWLviIWn+pbsw1WNyVDPDyprr6qbRMPn5O0csSc1QggI2L02FSbIS5mUQd4CoDZ+EBuE2YtMCYyMwi5nOtONV68csRNqHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvl9tsOe6j0103S9UJh3XQbayy+iHD3eW8XJDjfVG6I=;
 b=mrSYcWXLj3zX6xn//pjMrJyOrc+T0vwhyrpzgFmYUz7GLS17eWtMlWjw92tJ6NR1F9SU5r2lSxVlL+IbRgDHdjDN4Z3UQ0leheAINicM55Zwf4WD1HomxMdJGtKy+oeh5Vg+VGzQxI++euVYaFqpP/jjW65xAgjSf9/YSsymSkb9I08e04cAyH3n1kv/bySpeeio1kCku1zhq9Vx6kzw2MDQ6GUXaNK+wicJmJb6TtgSXYkEYaD8kHv0MohtI8ar8Ye08GlBrP3/Nbnta/SkmQsIyOfzYJ1BhedBva3NhEjbS7yUqWZ5a1Xcnp+u7D4YWV3e1H+hoknzooTK7JKoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvl9tsOe6j0103S9UJh3XQbayy+iHD3eW8XJDjfVG6I=;
 b=j1leb6ZpyPrkHQyfxD4UkdDABQjEMVDBnphNLvQIdUIB9dF5BxbOrvT47orYmlUj1Rj/lN20ASiGDhR4nOB66DkqSYNoyE9gcLwVmQjZ/064U+UjZgF/++QrSqH7Zbm73wdwQKPRakALuvcb4lYrrWhYepO5XRX6b8JPTOJP86VoHjGc4ZU4boVVbRI9HoNx96kNvFzwCKCQb5oQub5e95SM/i5/XYqaR+rc/1DxuNuMopN3SfFvPpJBbxO5yOMel9i/hGCOEi9sG4VJrD8J3V6YkucF7fGAsdyaYTq26U7MKY9oIVAiEyRCxFcahbg5WEnW5XDJZF2Med6vwPTM0Q==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by PAVPR02MB9254.eurprd02.prod.outlook.com (2603:10a6:102:32d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:17:57 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 09:17:57 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWU=
Date:   Thu, 25 Aug 2022 09:17:57 +0000
Message-ID: <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
In-Reply-To: <YwclcEJDf/POuHw5@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8543bb92-82f1-48d8-52c3-08da867ab2f0
x-ms-traffictypediagnostic: PAVPR02MB9254:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUHDGvrUurnoj8E/cP7t8bNAfZhyzzhQk+aQ97/mmCQSjcYa+ao6q46OL7CVJYwfzhLdlbMX9gNKBkPhWU7xuu6n4jh8zBKFzX+DJKFzQWB1aoyLLr3nJiPbzU6J3etcLCi+LOswHoeUvWekPMonhXXBrI1hUE65jI3uqu5492rqPGA27nF9e5gU9GFESIusQxifIxUMepMLaZ4pd9VzNXakzMR9HxPGIS6DkVM7/DvSi1pEBI2DdeSCXZB8J32847lrMMoncsCrFwf6UbTTXzPv90eNp2SSG01Gb7HzpU3Mb08cLlLvwFgfThItj8CUfEU/SjrDC4UDleKM2lMyNjLbrSfUYYcIBFo6X6MLxPeZW1/GZH/jLdnGdJek+ofyU3UrV3KRIsxgnsGgjprcK7esAobzdI34rB3m37xZP2kUpD3Ty87jLtK3ZVgQkdYEA1KQrLl6VZUnchII7Qx2CcVoI1tKQ82Va85FHPsdMggUpMbnrsqgsQqBnQ3EbY2DHjZyo6XoM15Yt5D6mpLARkykbEzmqeXT7foBBJqwBoOUKDxRLJooLv+ZaMEOOybSP/ay6AiidVcv3mfGbMeB/F2zrUkQVD5oTL/GIxts8gUrPwqzQNVO1PwGs0wlJLEXSd90jabyg8v4rkkoXjtcfHyjUYVQnmhiuxYUF648jZQsQ2FUkKdc6xBbSLTDpZtaGlJIT9bf/Em+1uEpX1IKXkkkrsJvP/Sf0/jdeIyKADlFk6wtJCJvBzp5hMaNfYXjo4N7miGhx1bAkh+F+6wYWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(8676002)(316002)(66946007)(82960400001)(66556008)(122000001)(86362001)(4326008)(38070700005)(64756008)(26005)(66446008)(38100700002)(66476007)(33656002)(2906002)(6506007)(91956017)(9686003)(76116006)(7696005)(71200400001)(83380400001)(52536014)(186003)(478600001)(30864003)(6916009)(5660300002)(55016003)(8936002)(54906003)(7416002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XvRYD+jjTvz0/wnGDWxq+NcAN9phNNlhFOrQ2JLEveVxjtCeJcAOw/OWWA?=
 =?iso-8859-1?Q?XVTFoxgnbrntPy/OrGwmXeyiccu/Iqsiq3SjQjNZvh0mAP/nTAe7fvkqaI?=
 =?iso-8859-1?Q?szZRG45/Wozkzq60TUSHi/hX+M48ytg/0Zw419cznGzq+jybEmacRr+S2+?=
 =?iso-8859-1?Q?nfUI9xk7RPyc59c+aZ4DCzAf0DAqLZWmcRaFmvm3+/vCr2doVVN4RyZuF1?=
 =?iso-8859-1?Q?UJ9v+62TCoZGfBvamjZp1Jq7pT0VpZzu4+wBNj2z65IeqavbjeZlVGRjab?=
 =?iso-8859-1?Q?z+BOHbrQtXdP7eXF2QM999GMdGx56Cu1p/V0MJ1/Mn0sugrFitFgB2AiWG?=
 =?iso-8859-1?Q?TFNUYtQB3RX/zeIb0fO2SM8Od8mxtmuDrzMHIT5m3tXarh643Lkqv2jKah?=
 =?iso-8859-1?Q?nF2BZJF1yWxZx3kvi0Ng946gXoqOH8fU9OkAeCMYdheRaQznu6YifMe8+4?=
 =?iso-8859-1?Q?Cy0JvlLn0OfKpi6053kPtcWgMEdXeSzdxqZtNaZm+/4fTlty2qAIiNxVn5?=
 =?iso-8859-1?Q?PJrlczB1SICUjSscErYrrYwiKO3P5NC85l/wtJIaRpQKLyBpHkbjnTonmo?=
 =?iso-8859-1?Q?a7ThQw/r72t0BqUZ8H12T8zG4HUz1vDd1SiiyDus1OKoE/ievLna6D/9aS?=
 =?iso-8859-1?Q?ElZHzfFofvPbE4CDmqpaSVL3JdghtY8RzJhUGw566hqptlYVb1x+qPJF2n?=
 =?iso-8859-1?Q?07VyBMq4hOT4sYztnbCEBYJ/SstyCX5iAWcejWyVFeILEW1C5iAcevan+o?=
 =?iso-8859-1?Q?2awpr+Zy6WPfYImVOBgeRQwmFyvuvcCNqJdqKNQnh+9GXNCSC4iKKROXYs?=
 =?iso-8859-1?Q?8quXF2vbd+U/zH2iGUSrb6VPf0e5zQ831Ys7RGkjzwMUuio9XgF+5q7r8H?=
 =?iso-8859-1?Q?YjCqGPPE38B6giElGn8AMom00ucSVQwDLh6asS0u9aOCwmtmp29qBHtaeI?=
 =?iso-8859-1?Q?jwqiKbyixbNZYx8qE+kYwCWOkxB33OaMFnPaoHsIz/9I9E0GFZDTp4bGHO?=
 =?iso-8859-1?Q?CW8xddlJ+ywwMTshIR30IA3NN1GgGuCPGd9gMkdEoFnKfvTyaM9P/6ksPX?=
 =?iso-8859-1?Q?cCLiu93DA+37svFhDwHn2YuIdkIi3le7tKB8rm8l9QvSK2Y/2/qtSo/cod?=
 =?iso-8859-1?Q?F0+8J4tNBlvTZ9IwGIiEANNnGGZUkkqyBcLriTEphoRoX24MVhw7VaUr4Z?=
 =?iso-8859-1?Q?ggAz7H36DJDZkv2Z9i2gF8dDiRaN9wxMoTl5TB4EpkNDj3FVe2n0RLciKB?=
 =?iso-8859-1?Q?HSZZFYpY8+dfLFgHGmX97sbS8oF6Qf3zno5Jc0WF+S0hcSdoecd6EwMJa3?=
 =?iso-8859-1?Q?sJbiJqFSfzcQIbZfFkGY3SeJph/TsHnf6SpTVjb08EKngnU1fFQW33i2VJ?=
 =?iso-8859-1?Q?ewq6y6cRm9S+8uAa0n2tlvLjmYzNg5lRknyofVh0lOL6Y44+wTQmGe07cV?=
 =?iso-8859-1?Q?jArybYbOtvmPbPtkqsI/2jAAeUVQse+yUa+qNOqqcrp+Lf/HEMJYUBDDkq?=
 =?iso-8859-1?Q?KZgYNUKhSOueXZwBBiCTsjRUZj0+jWL1O23AfX1GyDQ8DqlyQ4K5sw3nJ8?=
 =?iso-8859-1?Q?OMQXLCKCgDFrHxL2b4cNpZZXOw9rRlMBFob631Cixt9ymVaUZEbwMPna+N?=
 =?iso-8859-1?Q?MFbX9XhsQhLeoe5AQCymQTkR3jXIYBLEM0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8543bb92-82f1-48d8-52c3-08da867ab2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 09:17:57.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJYbSP/HB5zsFslhUcSBGWHANCJFoEtdVUv/JYXozD3yyDjxViWHQSgGyKmQC4uGgQZAiFYG2Z/fIYlU+2UWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Greg,=0A=
=0A=
thank you for the comments, see my comment below.=0A=
>On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> Introducing the vSMP guest driver which allows interaction with the=0A=
>> vSMP control device when running a Linux OS atop of the vSMP hypervisor.=
=0A=
>> vSMP is a resource aggregation hypervisor from SAP.=0A=
>> =0A=
>> The driver comprises of api part which facilitates communication with=0A=
>> the hypervisor and version which displays the hypervisor's version.=0A=
>> =0A=
>> This patch s based on previous patches sent to the staging tree mailing=
=0A=
>> lists=0A=
>> =0A=
>> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>=0A=
>> Acked-by: Leonid Arsh <leonid.arsh@sap.com>=0A=
>> Acked-by: Oren Twaig <oren.twaig@sap.com>=0A=
>> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>=0A=
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
>> CC: Arnd Bergmann <arnd@arndb.de>=0A=
>> CC: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>> CC: Andra Paraschiv <andraprs@amazon.com>=0A=
>> CC: Borislav Petkov <bp@suse.de>=0A=
>> CC: Brijesh Singh <brijesh.singh@amd.com>=0A=
>> CC: Eric Biggers <ebiggers@google.com>=0A=
>> CC: Fei Li <fei1.li@intel.com>=0A=
>> CC: Hans de Goede <hdegoede@redhat.com>=0A=
>> CC: Jens Axboe <axboe@kernel.dk>=0A=
>> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0A=
>> =0A=
>> v1 -> v2:=0A=
>>=A0=A0=A0=A0=A0=A0=A0 - fix -0 var init in add_sysfs_entries (pointed out=
 by Dan Carpenter)=0A=
>> ---=0A=
>>=A0 Documentation/ABI/stable/sysfs-driver-vsmp |=A0=A0 5 +=0A=
>>=A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +=0A=
>>=A0 drivers/virt/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +=0A=
>>=A0 drivers/virt/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 2 +=0A=
>>=A0 drivers/virt/vsmp/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 11 +=0A=
>>=A0 drivers/virt/vsmp/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 7 +=0A=
>>=A0 drivers/virt/vsmp/api/api.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 249 +++++++++++++++++++++=0A=
>>=A0 drivers/virt/vsmp/api/api.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 69 ++++++=0A=
>>=A0 drivers/virt/vsmp/include/registers.h=A0=A0=A0=A0=A0 |=A0 12 +=0A=
>>=A0 drivers/virt/vsmp/version/version.c=A0=A0=A0=A0=A0=A0=A0 | 118 ++++++=
++++=0A=
>>=A0 drivers/virt/vsmp/version/version.h=A0=A0=A0=A0=A0=A0=A0 |=A0 14 ++=
=0A=
>>=A0 drivers/virt/vsmp/vsmp_main.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
| 110 +++++++++=0A=
>>=A0 12 files changed, 605 insertions(+)=0A=
>=0A=
>Why do you have all of these different .c and .h files for only 600=0A=
>lines of code?=A0 Shouldn't this all just be in a single .c file?=A0 Why=
=0A=
>have a subdir for just 300 lines?=0A=
>=0A=
>Please mush this all into a single .c file going forward, speading it=0A=
>out like this makes no sense.=0A=
the current driver has two modules, version and api, in later versions of t=
he=0A=
driver support for additional features will be added.=0A=
at that time, this might cause the single file to inflate, so we thought to=
 split it=0A=
to several files to make it more organized.=0A=
is there any way to keep it in different code files?=0A=
=0A=
>=0A=
>>=A0 create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/Kconfig=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/Makefile=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/api/api.c=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/api/api.h=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/include/registers.h=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/version/version.c=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/version/version.h=0A=
>>=A0 create mode 100644 drivers/virt/vsmp/vsmp_main.c=0A=
>> =0A=
>> diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentation/=
ABI/stable/sysfs-driver-vsmp=0A=
>> new file mode 100644=0A=
>> index 000000000000..18a0a62f40ed=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/ABI/stable/sysfs-driver-vsmp=0A=
>> @@ -0,0 +1,5 @@=0A=
>> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/hypervisor/vsmp/version=0A=
>> +Date:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Aug 2022=0A=
>=0A=
>August is almost over :(=0A=
will fix, thank!=0A=
=0A=
>=0A=
>> +Contact:=A0=A0=A0=A0=A0=A0=A0 Eial Czerwacki <eial.czerwacki@sap.com>=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 linux-vsmp@sap.com=0A=
>=0A=
>No need for an alias here.=0A=
it's not an alias, it is a shard mailbox for the team so others can=0A=
view the mails history.=0A=
I saw that the same methodology is done with mailing lists.=0A=
=0A=
>=0A=
>> +Description:=A0=A0=A0 Shows the full version of the vSMP hypervisor=0A=
>=0A=
>That's not very descriptive, what is this supposed to look like?=0A=
I'll update the entry with the general structure of the format.=0A=
=0A=
>=0A=
>=0A=
>> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>> index f512b430c7cb..cf74089c4d19 100644=0A=
>> --- a/MAINTAINERS=0A=
>> +++ b/MAINTAINERS=0A=
>> @@ -21783,6 +21783,12 @@ F:=A0=A0 lib/test_printf.c=0A=
>>=A0 F:=A0=A0 lib/test_scanf.c=0A=
>>=A0 F:=A0=A0 lib/vsprintf.c=0A=
>> =0A=
>> +VSMP GUEST DRIVER=0A=
>> +M:=A0=A0 Eial Czerwacki <eial.czerwacki@sap.com>=0A=
>> +M:=A0=A0 linux-vsmp@sap.com=0A=
>=0A=
>Again, no random aliases please, stick to a person as a contact.=0A=
see above comment=0A=
=0A=
>=0A=
>> +S:=A0=A0 Maintained=0A=
>> +F:=A0=A0 drivers/virt/vsmp=0A=
>> +=0A=
>>=A0 VT1211 HARDWARE MONITOR DRIVER=0A=
>>=A0 M:=A0=A0 Juerg Haefliger <juergh@gmail.com>=0A=
>>=A0 L:=A0=A0 linux-hwmon@vger.kernel.org=0A=
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig=0A=
>> index 87ef258cec64..9f283f476674 100644=0A=
>> --- a/drivers/virt/Kconfig=0A=
>> +++ b/drivers/virt/Kconfig=0A=
>> @@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"=0A=
>> =0A=
>>=A0 source "drivers/virt/coco/sev-guest/Kconfig"=0A=
>> =0A=
>> +source "drivers/virt/vsmp/Kconfig"=0A=
>> +=0A=
>>=A0 endif=0A=
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile=0A=
>> index 093674e05c40..159ba37cb471 100644=0A=
>> --- a/drivers/virt/Makefile=0A=
>> +++ b/drivers/virt/Makefile=0A=
>> @@ -11,3 +11,5 @@ obj-$(CONFIG_NITRO_ENCLAVES)=A0=A0=A0=A0=A0=A0=A0 +=3D=
 nitro_enclaves/=0A=
>>=A0 obj-$(CONFIG_ACRN_HSM)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D=
 acrn/=0A=
>>=A0 obj-$(CONFIG_EFI_SECRET)=A0=A0=A0=A0 +=3D coco/efi_secret/=0A=
>>=A0 obj-$(CONFIG_SEV_GUEST)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D c=
oco/sev-guest/=0A=
>> +=0A=
>> +obj-$(CONFIG_VSMP)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D vsmp/=0A=
>=0A=
>Why a blank line?=0A=
>=0A=
>> diff --git a/drivers/virt/vsmp/Kconfig b/drivers/virt/vsmp/Kconfig=0A=
>> new file mode 100644=0A=
>> index 000000000000..4e1d7e0dc746=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/Kconfig=0A=
>> @@ -0,0 +1,11 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0-only=0A=
>> +config VSMP=0A=
>> +=A0=A0=A0=A0 tristate "vSMP Guest Support"=0A=
>> +=A0=A0=A0=A0 depends on SYS_HYPERVISOR && X86_64 && PCI=0A=
>> +=A0=A0=A0=A0 help=0A=
>> +=A0=A0=A0=A0=A0=A0 Support for vSMP Guest Driver.=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0 This driver allows information gathering of data fro=
m the vSMP hypervisor when=0A=
>> +=A0=A0=A0=A0=A0=A0 running on top of a vSMP-based hypervisor.=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0 If unsure, say no.=0A=
>=0A=
>No module name information?=0A=
will fix both=0A=
=0A=
>=0A=
>=0A=
>> diff --git a/drivers/virt/vsmp/Makefile b/drivers/virt/vsmp/Makefile=0A=
>> new file mode 100644=0A=
>> index 000000000000..f637097e19f2=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/Makefile=0A=
>> @@ -0,0 +1,7 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
>> +#=0A=
>> +# Makefile for vSMP Guest drivers=0A=
>> +#=0A=
>> +=0A=
>> +obj-$(CONFIG_VSMP) =3D vsmp.o=0A=
>> +vsmp-y :=3D vsmp_main.o api/api.o version/version.o=0A=
>> diff --git a/drivers/virt/vsmp/api/api.c b/drivers/virt/vsmp/api/api.c=
=0A=
>> new file mode 100644=0A=
>> index 000000000000..6e40935907bc=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/api/api.c=0A=
>> @@ -0,0 +1,249 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +=0A=
>> +/*=0A=
>> + * vSMP driver api=0A=
>=0A=
>"driver api?"=A0 What is that?=0A=
will update headers better after the files structure is decided=0A=
=0A=
>=0A=
>> + * (C) Copyright 2022 SAP SE=0A=
>> + */=0A=
>> +=0A=
>> +#include "api.h"=0A=
>> +=0A=
>> +static void __iomem *cfg_addr;=0A=
>> +static struct kobject *vsmp_sysfs_kobj;=0A=
>> +static struct pci_dev *vsmp_dev_obj;=0A=
>=0A=
>Do not make it so that you can only have one device in the system like=0A=
>this.=A0 Make it dynamic and properly tie into the driver model and then=
=0A=
>you will have no such restrictions at all.=0A=
there can be only one such device on the system.=0A=
=0A=
>=0A=
>> +=0A=
>> +/* R/W ops handlers */=0A=
>=0A=
>I do not understand this comment at all, which is not a good sign...=0A=
will update such comments to be more informative=0A=
=0A=
>=0A=
>> +=0A=
>> +/*=0A=
>> + * Init a vsmp firmware operation object=0A=
>> + */=0A=
>> +int vsmp_init_op(struct fw_ops *op, ssize_t max_size,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum vsmp_fw_action action)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 op->hwi_block_size =3D max_size;=0A=
>> +=A0=A0=A0=A0 op->action =3D action;=0A=
>> +=A0=A0=A0=A0 op->buff_offset =3D op->hwi_block_size;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 op->buff =3D kzalloc(op->hwi_block_size, GFP_KERNEL);=0A=
>> +=A0=A0=A0=A0 if (!op->buff)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 vsmp_reset_op(op);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return 0;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Release an vsmp firmware operation object=0A=
>> + */=0A=
>> +void vsmp_release_op(struct fw_ops *op)=0A=
>=0A=
>Why are all of these global symbols?=0A=
>=0A=
>If you put it all into one .c file, it's much easier.=0A=
>=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 if (!op) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON(!op);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (!op->buff) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON(!op->buff);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 kfree(op->buff);=0A=
>> +=A0=A0=A0=A0 memset(op, 0, sizeof(*op));=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Reset a vsmp firmware operation object=0A=
>> + */=0A=
>> +void vsmp_reset_op(struct fw_ops *op)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 memset(op->buff, 0, op->hwi_block_size);=0A=
>> +=A0=A0=A0=A0 op->buff_offset =3D op->hwi_block_size;=0A=
>> +}=0A=
>> +=0A=
>> +/* Regs/Buffs R/W handlers */=0A=
>> +=0A=
>> +/*=0A=
>> + * Read a value from a specific register in the vSMP's device config sp=
ace=0A=
>> + */=0A=
>> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 u64 ret_val;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 switch (type) {=0A=
>> +=A0=A0=A0=A0 case VSMP_CTL_REG_SIZE_8BIT:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D readb(cfg_addr + reg);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 case VSMP_CTL_REG_SIZE_16BIT:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D readw(cfg_addr + reg);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 case VSMP_CTL_REG_SIZE_32BIT:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D readl(cfg_addr + reg);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 case VSMP_CTL_REG_SIZE_64BIT:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D readq(cfg_addr + reg);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(get_dev(), "Unsupported re=
g size type %d.\n", type);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D (u64) -EINVAL;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 dev_dbg(get_dev(), "%s: read 0x%llx from reg 0x%llx of %d =
bits\n",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __func__, ret_val, reg, (type + 1)=
 * 8);=0A=
>> +=A0=A0=A0=A0 return ret_val;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Read a buffer from the bar byte by byte for halt on=0A=
>> + * null termination.=0A=
>> + * Expected buffs are strings.=0A=
>> + */=0A=
>> +static ssize_t read_buff_from_bar_in_bytes(char *out, u8 __iomem *buff,=
 ssize_t len)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 u32 i;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 for (i =3D 0; i < len; i++) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 out[i] =3D ioread8(&buff[i]);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!out[i])=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>=0A=
>So even if there is a failure here (0?), you return success?=0A=
you are correct, thanks=0A=
=0A=
>=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return i;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Read a buffer from a specific offset in a specific bar,=0A=
>> + * maxed to a predefined len size-wise from the vSMP device=0A=
>> + */=0A=
>> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bool halt_on_null)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 u8 __iomem *buff;=0A=
>> +=A0=A0=A0=A0 u64 bar_start =3D pci_resource_start(vsmp_dev_obj, bar);=
=0A=
>> +=A0=A0=A0=A0 u32 bar_len =3D pci_resource_len(vsmp_dev_obj, bar);=0A=
>> +=A0=A0=A0=A0 ssize_t actual_len =3D len;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 /* incase of overflow, warn and use max len possible */=0A=
>> +=A0=A0=A0=A0 if ((offset + len) > bar_len) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON((offset + len) > actual_le=
n);=0A=
>=0A=
>Please no new WARN_ON, just handl the error properly and recover from=0A=
>it.=0A=
I miss understood the checkpatch output=0A=
=0A=
>=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 actual_len =3D bar_len - offset;=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(get_dev(), "%lu overflows =
bar len, using %ld len instead\n",=0A=
>=0A=
>get_dev() is not a good function name for the global symbol space at=0A=
>all.=A0 Just pass in your device (hint, you have it here already), and use=
=0A=
>that.=0A=
thanks, I'll look into it=0A=
=0A=
>=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len, actua=
l_len);=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 buff =3D ioremap(bar_start + offset, actual_len);=0A=
>> +=A0=A0=A0=A0 if (!buff)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (halt_on_null)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 read_buff_from_bar_in_bytes(out, b=
uff, len);=0A=
>> +=A0=A0=A0=A0 else=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy_fromio(out, buff, len);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 iounmap(buff);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return 0;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Generic function to read from the bar=0A=
>> + */=0A=
>> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 char *buf, loff_t off, ssize_t count)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 ssize_t ret_val =3D 0;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (op->buff_offset >=3D op->hwi_block_size) {=A0=A0=A0 /*=
 perform H/W op */=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vsmp_reset_op(op);=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret_val =3D vsmp_read_buff_from_ba=
r(bar, reg, op->buff, op->hwi_block_size, false);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret_val) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(ge=
t_dev(), "%s operation failed\n",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 (op->action =3D=3D FW_READ) ? "read" : "write");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 op->buff_offset =3D 0;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (ret_val)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret_val;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return memory_read_from_buffer(buf, count, &op->buff_offse=
t, op->buff, op->hwi_block_size);=0A=
>> +}=0A=
>> +=0A=
>> +/* sysfs handlers */=0A=
>> +=0A=
>> +/*=0A=
>> + * Register the vSMP sysfs object for user space interaction=0A=
>> + */=0A=
>> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 int error =3D -EINVAL;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (vsmp_sysfs_kobj && bin_attr) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D sysfs_create_bin_file(vs=
mp_sysfs_kobj, bin_attr);=0A=
>=0A=
>You raced userspace and lost :(=0A=
not sure I understand, can you elaborate more please?=0A=
>=0A=
>And why is your version file a binary file?=A0 It should just be a small=
=0A=
>text string, right?=0A=
not so small, it can reach up to 512kb.=0A=
that is why I decided to go with binary, I understood that the text is rath=
er limited.=0A=
=0A=
>=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(ge=
t_dev(), "Failed to register sysfs entry (%d)\n", error);=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return error;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Deregister the vSMP sysfs object for user space interaction=0A=
>> + */=0A=
>> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr)=
=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 if (vsmp_sysfs_kobj && bin_attr)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_remove_bin_file(vsmp_sysfs_k=
obj, bin_attr);=0A=
>> +}=0A=
>=0A=
>Why all the indirection here?=A0 Once you clean this up to be in one file,=
=0A=
>it will be much smaller as you will not need this middle layer at all.=0A=
>=0A=
>> +=0A=
>> +/* Generic functions */=0A=
>> +=0A=
>> +/*=0A=
>> + * Open the cfg address space of the vSDP device=0A=
>> + */=0A=
>> +int open_cfg_addr(struct pci_dev *pdev)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 u64 cfg_start;=0A=
>> +=A0=A0=A0=A0 u32 cfg_len;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 vsmp_dev_obj =3D pdev;=0A=
>> +=A0=A0=A0=A0 cfg_start =3D pci_resource_start(vsmp_dev_obj, 0);=0A=
>> +=A0=A0=A0=A0 cfg_len =3D pci_resource_len(vsmp_dev_obj, 0);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cfg_start, cfg_start + cfg_len);=
=0A=
>=0A=
>Again, you have a device, use that.=A0 Goes for the whole driver.=0A=
I think I've missed something, please correct me if I'm wrong,=0A=
I don't need to save the pdev because there is an existing framework=0A=
that provides it?=0A=
=0A=
>=0A=
>> +#define FILE_PREM 0444=0A=
>=0A=
>File permission of what?=A0 And shouldn't it be "PERM", not "PREM"?=A0 And=
=0A=
>why do you need it at all?=A0 Just use the proper sysfs macros and you=0A=
>never need it.=A0 See below.=0A=
all the sysfs files (1 for now) should be read for all users.=0A=
=0A=
>=0A=
>> +=0A=
>> +/* Regs/Buffs R/W handlers */=0A=
>> +#define vsmp_read_reg32_from_cfg(_reg_) \=0A=
>> +=A0=A0=A0=A0 ((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_3=
2BIT))=0A=
>> +=0A=
>> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type);=0A=
>> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 char *buf, loff_t off, ssize_t count);=0A=
>> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bool halt_on_null);=0A=
>> +=0A=
>> +typedef int (*sysfs_register_cb)(void);=0A=
>> +typedef void (*sysfs_deregister_cb)(void);=0A=
>> +=0A=
>> +struct sysfs_entry_cbs {=0A=
>> +=A0=A0=A0=A0 sysfs_register_cb reg_cb;=0A=
>> +=A0=A0=A0=A0 sysfs_deregister_cb dereg_cb;=0A=
>> +};=0A=
>> +=0A=
>> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr);=0A=
>> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr);=
=0A=
>> +=0A=
>> +int open_cfg_addr(struct pci_dev *pdev);=0A=
>> +int init_sysfs(void);=0A=
>> +void cleanup(void);=0A=
>> +const struct device *get_dev(void);=0A=
>> +#endif /* VSMP_API_H */=0A=
>> diff --git a/drivers/virt/vsmp/include/registers.h b/drivers/virt/vsmp/i=
nclude/registers.h=0A=
>> new file mode 100644=0A=
>> index 000000000000..b6458d25e3b7=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/include/registers.h=0A=
>> @@ -0,0 +1,12 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>> +/*=0A=
>> + * vSMP driver registers=0A=
>> + * (C) Copyright 2022 SAP SE=0A=
>> + */=0A=
>> +=0A=
>> +#ifndef VSMP_REGSITERS_H=0A=
>> +#define VSMP_REGSITERS_H=0A=
>> +=0A=
>> +#define VSMP_VERSION_REG 0x0c=0A=
>> +=0A=
>> +#endif /* VSMP_REGSITERS_H */=0A=
>=0A=
>Smallest .h file ever.=A0=A0 12 lines for a single #define, please don't d=
o=0A=
>that.=0A=
you are right, it should be atleast part of the api header=0A=
=0A=
>=0A=
>=0A=
>> diff --git a/drivers/virt/vsmp/version/version.c b/drivers/virt/vsmp/ver=
sion/version.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..d8ad771daf28=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/virt/vsmp/version/version.c=0A=
>> @@ -0,0 +1,118 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +=0A=
>> +/*=0A=
>> + * vSMP driver version module=0A=
>> + * (C) Copyright 2022 SAP SE=0A=
>> + */=0A=
>> +=0A=
>> +#include <linux/slab.h>=0A=
>> +#include <linux/kobject.h>=0A=
>> +=0A=
>> +#include "../api/api.h"=0A=
>> +#include "../include/registers.h"=0A=
>> +=0A=
>> +/*=0A=
>> + * This is the maximal possible length of the version which is a text s=
tring=0A=
>> + * the real len is usually much smaller, thus the driver uses this once=
 to read=0A=
>> + * the version string and record it's actual len.=0A=
>> + * From that point and on, the actual len will be used in each call.=0A=
>> + */=0A=
>> +#define VERSION_MAX_LEN (1 << 19)=0A=
>> +=0A=
>> +static struct fw_ops op;=0A=
>> +=0A=
>> +static ssize_t version_read(struct file *filp, struct kobject *kobj,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct bin_attribute *bin_attr,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 char *buf, loff_t off, size_t count)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 u64 reg_val =3D vsmp_read_reg32_from_cfg(VSMP_VERSION_REG)=
;=0A=
>> +=A0=A0=A0=A0 ssize_t ret_val;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (reg_val < 0) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(get_dev(), "Failed to valu=
e of reg 0x%x\n", VSMP_VERSION_REG);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 ret_val =3D vsmp_generic_buff_read(&op, 0, reg_val, buf, o=
ff, count);=0A=
>> +=A0=A0=A0=A0 if (ret_val < 0) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(get_dev(), "Failed to read=
 version (%ld)\n", ret_val);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 buf[ret_val++] =3D '\n';=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return ret_val;=0A=
>> +}=0A=
>> +=0A=
>> +struct bin_attribute version_raw_attr =3D __BIN_ATTR(version, FILE_PREM=
,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ve=
rsion_read, NULL, VERSION_MAX_LEN);=0A=
>=0A=
>__BIN_ATTR_RO()?=0A=
>=0A=
>But again, why is this a binary file?=0A=
thanks, will use that, my bad.=0A=
as for the bin, if there is no size limitation for the str attribute, I'll =
switch to it.=0A=
>=0A=
>I stopped reviewing here.=A0 Please clean up all of the above first, and=
=0A=
>then the rest of the file will be smaller and easier to review.=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
I'll submit a new version after a proper file structure will be decided=0A=
thanks again for you comments.=0A=
=0A=
Eial=
