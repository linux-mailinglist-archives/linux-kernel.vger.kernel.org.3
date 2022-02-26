Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BE4C58BF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiB0ABC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiB0ABA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:01:00 -0500
X-Greylist: delayed 1054 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Feb 2022 16:00:22 PST
Received: from mx0a-00268f01.pphosted.com (mx0a-00268f01.pphosted.com [148.163.148.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F292294B7;
        Sat, 26 Feb 2022 16:00:22 -0800 (PST)
Received: from pps.filterd (m0165118.ppops.net [127.0.0.1])
        by mx0a-00268f01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21QLOQvd018374;
        Sat, 26 Feb 2022 23:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equinix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pps202002;
 bh=H+4XieM8mB6G25J0tyC/yx3zuxGn8PMQOu/H8Ai2uHg=;
 b=fa5/iLS8vLlOI6XqFgm0BiUa9ZfnILV/USkCS7eRI7AugSv+ylCHC3bQxAB2p1l44AOQ
 YU8cCMRqMRYEruqnNdMAIEkyAFl64tR9jSueFkJvTG1AMnFoXwK7qbOP0J5MqmotP5az
 bE87O8+ux4MB38fvD3QFUcnt9FzKqh9V8fpCNh8Ekth/TUyR/Qh2WPdWd0hRTDej8GRv
 Y2GrG8ii8z6RWY5qbd5bIpQyaCSBVD7KKzoublYj3HTL+ZDEZOZgvbQ1NwH06wpIm82s
 2rNeLjhaeRcBYGl2a+i5mKwR0VTcDINLi02QoscEa4ytL179qdv7KxoQyGrz1l4njSFo Jg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00268f01.pphosted.com (PPS) with ESMTPS id 3efa50jcgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Feb 2022 23:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhJ/4IrOnbbupKo0LJmhtSJpaBBhibtouJm2v2Q2WQlKKog3RH2WIyqEizwD1VTVf3ax1YotYQFfivpJhbNXyWwIva1B3CiuyLV1vQKQO86hUtMe5FAgYJY+bcTW96NjxHwux2NIDaZ5eXwvZD30/0WwbQQfCv8HACg08MeskrUfj3xDHohVOXS437faASrBYGkr85nX62mqaL0ftZG7vS0pizELhVBd8J0fCiCfLNY3S2u5hS9ZukjgzzDRTQMu7FSOp1AC4maGPupRw2Kef4831NaPfAAoplRHdBxSLW2ELs38TucPR4MtzlsismLFe4zX/jxzdKPWbVFMSkGhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+4XieM8mB6G25J0tyC/yx3zuxGn8PMQOu/H8Ai2uHg=;
 b=MDVjSOfaFknsbruU11uGAYVMt977AqMvb++PSJLeawHZ4Wtwtik/fgndQ4dIgvknAqlxkYmJxk3DH3kEhnt61dKr+729m/Z+RTGPWhuhKtshYT60kRmJfHD3xe5N7sPOGeUcwBA43zkmYSEEXlYcXIZQfBguwwNIGw2FB6nnUb++AyepWlp67KDuohlL0WOhup/5mcIJgfZTqMpsNkxoaUfEpYIu8jOhqhXL+kvj7kXlT8hTPd+l3eH3Gow057jIGSFbhoyjnZpShjEkCIrYZ8XTQIXa744i3e7EZY8qkeaQtuuvoroM75BND2i2Yc2oYqo6GEBj00CJaonRiHRQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=equinix.com; dmarc=pass action=none header.from=equinix.com;
 dkim=pass header.d=equinix.com; arc=none
Received: from DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20)
 by CY4PR0401MB3523.namprd04.prod.outlook.com (2603:10b6:910:90::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 23:59:47 +0000
Received: from DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::42f:1f1b:3a9b:b4a3]) by DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::42f:1f1b:3a9b:b4a3%4]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 23:59:47 +0000
From:   Zev Weiss <zweiss@equinix.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Thread-Topic: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Thread-Index: AQHYK2zucm6pB5CFbUePg8SbeUgg6Q==
Date:   Sat, 26 Feb 2022 23:59:46 +0000
Message-ID: <20220226235946.GW5754@packtop>
References: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
 <20220226234220.GV5754@packtop>
 <fcfe0d87-6755-a9e0-6237-fae889fbf2c7@roeck-us.net>
In-Reply-To: <fcfe0d87-6755-a9e0-6237-fae889fbf2c7@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13e350de-cdb7-436e-42a9-08d9f9841158
x-ms-traffictypediagnostic: CY4PR0401MB3523:EE_
x-microsoft-antispam-prvs: <CY4PR0401MB3523F3491FD0E0BE3BC8C436C33F9@CY4PR0401MB3523.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPk5yccmgkqFevpQBlfYHipgkpu89x+XPuCinp6G1vSmi41Ui9i8ItIgoENZtKS2627MrsNgTMQMl9G8CbEvvyYiDvPirnhe1LCjyPRp9/PLCNgPrxu4/OXQWga6LxKCg4wHUBH0dhqXavLs790eu66cDvj+Xi/d7N5ko+Iu9GZgCohPwjGB92z9z49zCKWr77/sRh+utBV/FQRu3eMgKUHPzKmWpm26ageAgwHOzqT82BitRHa3oepr7cLUECj1ESriguuMTKOmcSwcCKNAYQy8N7N7qzXZXPNHsFgpN4TR+cumvMU61HzBJqrZCXP88WooXC4eHCYBrhugywC9h2rtn3Wbspo0MSahM9qKZN0kAHUcDIDO12/ZLSSGQ9DeGM9lG9sg6+gKycbvAz0nugXaXPbdBhMQDQwHDN6hZ3LxoCVOiaklzLERUUaE2yDSMqSkDlnwi/8tEHgThSEubFOyq8TOOZX0SnJYVJr+2MOBjnqFfqOAAdugOiBNh86ll6iDGu56h6OzW6HQP9jPvxveZet1NsQkZAEGdg8JAwkvHejJ/eugFRCwfldRC3KzjU8zInXvmUXG10e48dNLVRxJZqSBotQZjvxmsnL5+4JQ/mdfUpr5zrpqLB+5qBaPVMlwe0P0Ai5KSs4PflLnFsNnJdh/MjAJRxbqZB/bllKALEu+tRmq28g8eHYv8eBqnATXYHDoGJza/WXbbX2XRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8007.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(26005)(83380400001)(1076003)(2906002)(6506007)(186003)(122000001)(38100700002)(86362001)(38070700005)(33716001)(6916009)(91956017)(33656002)(8936002)(54906003)(71200400001)(6486002)(8676002)(66476007)(66556008)(508600001)(316002)(4326008)(66446008)(64756008)(5660300002)(66946007)(76116006)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dctN5elzDZSC5JfnqDGzFat1he+S9VL6We4uqFHXxU27G2B8trqYmqlMu6I+?=
 =?us-ascii?Q?tQzspedM8NoH8Kv4/FLpDjhBi4DlNZP6fYcdvXYnIEmFH9Xa66cgrOU16xRj?=
 =?us-ascii?Q?vnyoBeYuBarm6vWdoTaw0Jdx/DrB4os3xJaB7K+E43vcAvEAfLpNE7s3l26B?=
 =?us-ascii?Q?APsGJoSTaCuX43wJGBiaXey+pJJj/8ymLF3sF0WrdFP7FzUQsew9AQNuAiK7?=
 =?us-ascii?Q?U1Z8ay0R7tUm4lxzJ44W4RMtJ9uTWffQuLWXPYrPAI5U3shH0xg93ZBVhH9i?=
 =?us-ascii?Q?wRp+BF1u9vCQFsKWSKE7wWUke1zWYvQb9hzBqorjuuWr0kZsIMVng2HzmWU2?=
 =?us-ascii?Q?ycv7Z/Q6rQVWJVkrVD4FZOCfAluLEZK953yoOn2YfpgtO3IHwBEhs2nrPhAr?=
 =?us-ascii?Q?xTzMjreDsKkpI9QapAKzqLcMW7OypvXUERLl0D9L/vqJXlxCksoNbmcw9Sra?=
 =?us-ascii?Q?FvBtPe5jDLgXFj0eVpuAzhg9soiREGlVBh30lt36anqsIN19OyWRX/eODOLV?=
 =?us-ascii?Q?91DfsaJ3JelUdqbDJB8ABosDY0ccexBrlzV3NFZlGhT1ex53N8UixeWOar3t?=
 =?us-ascii?Q?SO50SF0VT+09tbT1Gzd3U33/qriRoHtxj5qPAlIHBvPERljZ4M2jQcswhc5U?=
 =?us-ascii?Q?lbBXw2rDY9pr/4pXyl9Ahj69pbDzHfbWizWXP3COFQC9c7vPwSGN6qSOgctp?=
 =?us-ascii?Q?MrhF7sWNkfNB4upws9U+zDM7EoGE+BamslOjzUwQEu0/yJvWKI3afObZP1To?=
 =?us-ascii?Q?YzVemWFQpU7y5ZGFdNqqIOsm8iHgFwtIMKn5ox/BFaJ9gfnTDqdyHKWMQTLi?=
 =?us-ascii?Q?NQhIdwXjqq5iQaBpDW0V8xfVzLXFZyJ8VONCC0fOOFSeKZzFhRJVP1u8t8NS?=
 =?us-ascii?Q?txn8LWG8wbUQxKRhbvj61qyHmZ6CZd4FivndW9JKNkFexkCAk8ENMJnxce7S?=
 =?us-ascii?Q?VGtzlz28EJsCRs5hjrKtkvNWHmgG6KKZrEV/fIYh6nbRio1BfiwIdpKRO46g?=
 =?us-ascii?Q?Ig9c8FUIPmHfIa+4eS2BeaSnZVmjO9820lEhc9WMyJDoPTSSGAbIWFJQw7pv?=
 =?us-ascii?Q?zld4xtWOAd3EyLOBTfBS2GX5T38VLw+7sTBKtzFw7d9l/il9hCXbcBDvelrv?=
 =?us-ascii?Q?XrdU4T1qiFM0UcgBIrfFx6k14tUvSQHyV67yVIxqv1qwXCaxk5zncofB9jVM?=
 =?us-ascii?Q?uEC7BFRRpznbwmqFVaxProq/GjYHKi8M+h5olfWEtq1yFbSteWITTQRje30L?=
 =?us-ascii?Q?4gsMmEg4H3Px0AicX3ndNNnnNiEn4oKapNmzQlQ3NH+U9qJe8k/zMgCL7KYP?=
 =?us-ascii?Q?6pTx0RU7r+AwtN5xQ/ZKiHRaKRcpdm7mrwWviDWvQEvs6VEZ3b/dpBfrsBBN?=
 =?us-ascii?Q?yQV0q0kFJnogL3FblygBeCUeMDYCax7xa6lSu6X0To5joGv4b9G/Y6dcVDTP?=
 =?us-ascii?Q?RpAABApTCr+UIh9+fe3UshawUnMQ9NTHdETPPJJ4V0uyrmZYZrWU0bjacu+5?=
 =?us-ascii?Q?CWo5K4GLga/704MgpkvVMiOkb7Ks1qylykTJRGRJUC4kiSZ38zYbYPABSJGX?=
 =?us-ascii?Q?vonC+MEIXSbdeu1Jr6vMOJT0f2VsxY/dy0f6eXVa6PX2a0IHXnX8pr0Xz+Kx?=
 =?us-ascii?Q?eNM1aFMspA40v5PXAjZXGSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19B162A2C74045429CBBCC766C6AD35E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: equinix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e350de-cdb7-436e-42a9-08d9f9841158
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 23:59:47.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72adb271-2fc7-4afe-a5ee-9de6a59f6bfb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jiDD7ZK5egrX4s501EDP0SVas78SQ2GWlyZ0ho4/RTEAhemr+K21pr+C5bN87GcKHon53kVvy4iuy5DdL/grA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3523
X-Proofpoint-GUID: jol-M9vTEq5oMqT8rabst7CgvBtHCqw6
X-Proofpoint-ORIG-GUID: jol-M9vTEq5oMqT8rabst7CgvBtHCqw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-26_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=832
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202260171
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 03:47:41PM PST, Guenter Roeck wrote:
>On 2/26/22 15:42, Zev Weiss wrote:
>>On Fri, Feb 25, 2022 at 08:06:09AM PST, Marcello Sylvester Bauer wrote:
>>>From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>>On PMBUS devices with multiple pages, the regulator ops need to be
>>>protected with the update mutex. This prevents accidentally changing
>>>the page in a separate thread while operating on the PMBUS_OPERATION
>>>register.
>>>
>>>Tested on Infineon xdpe11280 while a separate thread polls for sensor
>>>data.
>>>
>>>Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>---
>>>drivers/hwmon/pmbus/pmbus_core.c | 16 +++++++++++++---
>>>1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbu=
s_core.c
>>>index 776ee2237be2..f79930162256 100644
>>>--- a/drivers/hwmon/pmbus/pmbus_core.c
>>>+++ b/drivers/hwmon/pmbus/pmbus_core.c
>>>@@ -2386,10 +2386,14 @@ static int pmbus_regulator_is_enabled(struct reg=
ulator_dev *rdev)
>>>{
>>>	struct device *dev =3D rdev_get_dev(rdev);
>>>	struct i2c_client *client =3D to_i2c_client(dev->parent);
>>>+	struct pmbus_data *data =3D i2c_get_clientdata(client);
>>>	u8 page =3D rdev_get_id(rdev);
>>>	int ret;
>>>
>>>+	mutex_lock(&data->update_lock);
>>>	ret =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>>>+	mutex_unlock(&data->update_lock);
>>>+
>>>	if (ret < 0)
>>>		return ret;
>>>
>>>@@ -2400,11 +2404,17 @@ static int _pmbus_regulator_on_off(struct regula=
tor_dev *rdev, bool enable)
>>>{
>>>	struct device *dev =3D rdev_get_dev(rdev);
>>>	struct i2c_client *client =3D to_i2c_client(dev->parent);
>>>+	struct pmbus_data *data =3D i2c_get_clientdata(client);
>>>	u8 page =3D rdev_get_id(rdev);
>>>+	int ret;
>>>
>>>-	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>>>-				      PB_OPERATION_CONTROL_ON,
>>>-				      enable ? PB_OPERATION_CONTROL_ON : 0);
>>>+	mutex_lock(&data->update_lock);
>>>+	ret =3D pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>>>+				     PB_OPERATION_CONTROL_ON,
>>>+				     enable ? PB_OPERATION_CONTROL_ON : 0);
>>>+	mutex_unlock(&data->update_lock);
>>>+
>>>+	return ret;
>>>}
>>>
>>>static int pmbus_regulator_enable(struct regulator_dev *rdev)
>>>--=20
>>>2.35.1
>>>
>>>
>>
>>Looks like this doesn't cover pmbus_regulator_get_error_flags(), which
>>was added recently -- perhaps rebase onto hwmon-next?
>>
>
>This is a bug fix which needs to be applied to stable releases, or am I
>missing something ?
>

Ah, true -- should it then be a two-patch series, with this as the first
for -stable and then a second for -next that extends it to include
pmbus_regulator_get_error_flags()?


Zev
