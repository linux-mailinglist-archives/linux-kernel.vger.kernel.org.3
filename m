Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFB489051
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiAJGpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:45:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13376 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbiAJGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:45:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A0qrWN007008;
        Mon, 10 Jan 2022 06:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=Z8kpINvJP58D1HkOkDLag6JHWgTMaqcirVhZpqoePts=;
 b=yb3RClyIhecWMIFiT/R2Alh0FQk+Cl81DVdWQqVP7taS+s9ka3UaDe/DLENHFxQ0DsLf
 dyJ31eb93QRdj5gA/l27txVqxa7ZbQPqAnBpB7dHS2GJa+LcG/FsAYN/pGolAouT6Tr6
 t/aBsTYddCKsoVhpdqe5judxR1o6U3kEpQRjCtoQPxaB9tiw8mW+CcyFpowvPjpQW+9m
 IreUBXB7rT31XTUUox8okKwgZHaDxLhLDr9kYkqZkvdl7qTF4ItqLUlVI5atSoQsufSC
 UeXm+QbO4N9zniLh3vc8HyX9DBMt8F/ZPH9dfbwPn2Qyo6ncYWpeHji03zNs6rTTzPXh qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1d2tah1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:44:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6fsTi025660;
        Mon, 10 Jan 2022 06:44:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3df2e2vtr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc6i3K00Uej2vXphS/e6w8hUAVSVnHJNn4oSKzz+U9+RRRl64cBNfDWUrefry5Zw+JEPHjsoFMqAwAXPuev5O8GeghGnOYVLKaPWcTjXrDV3TlTpQisbD06xDlh0WxtlIzGDuTZQ+MGDxaDQbuiS5cULbapzsFyrKiORX5d5gs/v3C982z22bhij3+wkhcdyyyHG3HbKjIRh7+fJqPCX7jWVLHvlRoYXvVAMMC8cQrlKjM7u4QJdAms2288UomNSJqkYis39sv7GD8YtD/UXDYKkYCCvltvHJsD22eTel9E323I3qlN+Q/2MMNDdBB+MG43n0iB8ZhTElC0/v1ncdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8kpINvJP58D1HkOkDLag6JHWgTMaqcirVhZpqoePts=;
 b=Wv/OVckD8oI7h10doCUQzooUgOOXVxpWTiTo1uaNfz0DSmYCEOt7VVR6rhg7Ti00IVIipBYingWxSFpgHmvwmL2tKw8yskqNcsf6mYx0+Fv2hvYeg6wVLYHNs96WBQlfAqGaxvIDlf0ViiRePuRDfaVgspO2+EFcGIWAO69T6FB/Wq21l7o3870WDHDQac2CPJODblxmsUblm+aKXALMz8vcKDsxe7EcbbbqlnPCtbVb5ya1ko6XyQDogWwsebUsE8bzEqd4lnNAZkyxYeaNhRU9TswpJrAnFC0QOyT26Y3x/FXp9w/jMh4t7n3+8orhTs0jX7bp2PgkIUDWn/u3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8kpINvJP58D1HkOkDLag6JHWgTMaqcirVhZpqoePts=;
 b=nMDBUu9xn7SHj6UaHSzTGbBFpRz97qNCjNzczuhDnzTDer1VxUUAVpmxOOa+u9J8AQPBMO7QPErviVup+7qT1WnxWlM0TH77FTjWh1/MKA4yfdrp0Iw5hnDZzChZDbcSKZuL9l1DZhLinMaYEdPjSZhlJiof5ZavgW7M8BE4SsQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5807.namprd10.prod.outlook.com
 (2603:10b6:303:19a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Mon, 10 Jan
 2022 06:44:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 06:44:24 +0000
Date:   Mon, 10 Jan 2022 09:44:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Paul Cercueil <paul@crapouillou.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 2/2] hwmon: Add "label" attribute
Message-ID: <202201081730.TlHZabuC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105151551.20285-3-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0274bbe0-b0b8-4a23-e046-08d9d404a3b3
X-MS-TrafficTypeDiagnostic: MW5PR10MB5807:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58072D51F443CFA9D6B166B08E509@MW5PR10MB5807.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AQONrfTG2rtVmUJV1utik/WwNn04MBKJC3KsfvrpWXa+y+5eLc8kofEdBxQz3BvKjsaQaMQo1wgTpnAdrnh/mWUk6uOF8SbRnv3CD7M2Nmzi71BXm29tWnEiQUNtggNFa1Mej89RybNLWTt/aHMHQ1gnZfkn/NsDM/NGcLOgji/oBwTuUSGNkH7mQRMzivo8Xz76sW9jrhzhP4QN626s0xCLvCdKj62M9EX6uepNubIy9GU0nsgeKxNbzOwLXFj7NKfYwMtoXzo1HvwerVnY0Z4zPwAayf+TL06g1Ke7wyAhgsJ/vFsDMr7P0rx8rlEofk+f0xAiiY/uIZduqJFO125qIY7ZpzQvq2GEO7h1oiMF3pGdWargYRqvXTItFmLxOCKByNCoSjb+ir3c9+zCwdsE6YLEslAiFkQ/qHwH1+5SW+bOGWaMrJA134wtQzZTJNc93SouefUInJPQNqdawsmONNrCQXnzxrCGENOj2gkJa5z+AQ861VzhLIlu11u/sion71yAcKLUshH8WPernu0prqyy+UFYphP7O+VA4fxYcnKDsWgpzNKgXy3+67w7oNlJSFVpjGry9ouLrVCFaAAaap5iFGlWwNXVl4GFyi26CYysfQd6W5qH6JNiUwI0FUWaL13a/fpNCgpBo5QlBZGbPEf5C56tVEL4SHhALme5ccuK/WVr91x5tDVbzBzpc/nzvhU1YL3bheM4XDzUI3Yz5fZByBK9jdO8+D47JcMVBFB4v/dNh83aiBTSul3jPRrYrsv7HfvUqsDGfCchZS3ZTTdqJZGG6zK998Ph/C3WI+Jbe7SZvvc7GETOwSvu9z9z3uUBco3/Ki3GviLIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(26005)(186003)(54906003)(38350700002)(38100700002)(6512007)(4326008)(110136005)(508600001)(4001150100001)(7416002)(8936002)(44832011)(6486002)(6506007)(316002)(5660300002)(8676002)(9686003)(52116002)(83380400001)(66556008)(86362001)(36756003)(66946007)(66476007)(2906002)(1076003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2GyM98Q6VMRsJX3xEVqDc9mo6PU2IcAbcy45XQRls51HwJcpPebf2SUJyO5?=
 =?us-ascii?Q?Az0gvvSLxJMY40nPX9OCatqyWJ6xVk+Lamq2cpWociinut9BKKRva81xC550?=
 =?us-ascii?Q?42blad1cwidD+m4xZ+rRA5nUU/AaCzItWffvMsZdfB4Sv+bRZ5/oruXRNP8K?=
 =?us-ascii?Q?f9KDIb/OOHL51tPBrTQCvmENYa4/+QXG3m7q/VpHjhoD4Ju94ngkUbm8Je7V?=
 =?us-ascii?Q?6d5DuQ9uvpqqLaJDMyD4y/GD5WsjZAB7gsJFH8+iprCUEUiHNxPLm0wAZM/0?=
 =?us-ascii?Q?gy2gh76b5M5Bs7/wFrnLtnjilY0QGfpGUob07GRONMYhbYRycM2txUhOmNO4?=
 =?us-ascii?Q?J1guprpg3aZq8GiDH0tiSsHv5y2mS6q1WYAcdnBiPzpJ9TkrIrJQPzbsxeEI?=
 =?us-ascii?Q?cmb/J7R2X291SARoPnURVU2eq3S0gsmLDbbSZ2mVgQn2qDz0JaYzfeqDkiCc?=
 =?us-ascii?Q?+FxOYURSdwcW2O6rcLsyrs8gUUF5HOSP+cGkKb1XqjuGjq3ZbkylQg0FErB5?=
 =?us-ascii?Q?S4L9IaxWmQEP+6VY74csST9uB2CSXkVFcoXpEwXLImajMGJKQLEATLcCFBr0?=
 =?us-ascii?Q?SamBYacfgXookUJQb6EiTJRaLLUuneUwR2AcyVg5n27Y9h2qk3Dch6BmxkDq?=
 =?us-ascii?Q?WsWKl8cM7znBpq8asAUUYeqxsOx0QcIUM/NgTCkBU1YuaJjzZDPBinkWIrav?=
 =?us-ascii?Q?WCfG8dFO437CFJXzxdnQwvTrJ0ONFtqlc+IFB6ohDvecnyD02a+W+bvxcSCJ?=
 =?us-ascii?Q?Jxs3PsLV6kPYikAyKg32PlEqq4ZuT6/GA5kehN7vEmBmilHOxAOB9FgsaLbJ?=
 =?us-ascii?Q?TTtW2xJQMQ36+ZtUbWEl/jIIqOycMXFrDom1yhF3gS9jfWhH1ZwjwpkUbTPp?=
 =?us-ascii?Q?bgXh/5X1AlaWE5TSOBLJYXvSYNDzWhZzI3b/FrYHDQxCBZIF8VOpyGjE8o5z?=
 =?us-ascii?Q?XW/8gn/V8tDf3fCM5HGe8X5Tu2IybfEF6HFFfg2VeH8kGACqtnIiPnLPXEal?=
 =?us-ascii?Q?qcRtOXq69polgaEiWeMhDb6kI95jwtjjyL3UcFgxLfQHBNjdhF68XiGPZKch?=
 =?us-ascii?Q?E2GrN6ZtpqWM5qy9CkIXu79LTvsuNZ1l0uy1ZoLSkMyxg+IJxw1A7FkIBW8+?=
 =?us-ascii?Q?U2TJ9jOX9JVAOUIbgxTuNZVufxhBcIkPu8DwCD1VI4rlz2SULg8caqcsW75T?=
 =?us-ascii?Q?u7cRvtzsuuJHV2BcjZ7qy4PxFSZ/RrT2dq9jUaAGU4QP/LfYJvx0zCyRE41r?=
 =?us-ascii?Q?I5IbUTVGEKZQK6uTILL3rANl86M9mk4lOPrO+I/ciZefaoBelqOKxI7wuV+2?=
 =?us-ascii?Q?+IvUNLVfxOv60FqcBpWq5EEyLO1LqmLXh3pR+tXPzcQWYh8XbawYJNg0rThi?=
 =?us-ascii?Q?GDiMYi+8IfHF3K1nBnk4EoqbL2zubDvuaiP2O30W2MeydMCdmc/GNj11biO4?=
 =?us-ascii?Q?2deZhE9+h9DE4YG3VPPiGaf0BbVe7hSXMBajqco4GAKOwnaaFDnFYL8wa04F?=
 =?us-ascii?Q?QR1YJRRw6x2rU1Drh3AL2ss0BHVxo7B1ROyKWMWGbrY7CT/KQVHWDRvXRinv?=
 =?us-ascii?Q?/Tl9OODh6xYlmew1LO32LLcsIN619l5//pzKH9EnANkCtOkX54AMrZQdOnm5?=
 =?us-ascii?Q?T8xiSIbYTaTkTJTqzD5RS92iwJaDiZhqn3Z1tgBO3twvABBXLRk5evfwLZwm?=
 =?us-ascii?Q?QX4shd8m6jIgMA8/FkWTUoVSKOM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0274bbe0-b0b8-4a23-e046-08d9d404a3b3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:44:24.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkPuZGJcs1lUiSZcblNRYaq52xkSH7LtQLjdlHv+qrtnz2jmW+fSHhWIDWVcbo7ZPxhOwPyBAPMyGkHOusOYGFzB2nNYGQbis0+Zawv6FoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100045
X-Proofpoint-GUID: nUxqHSks-ZiyxOimFL5-SVazC0cRUW43
X-Proofpoint-ORIG-GUID: nUxqHSks-ZiyxOimFL5-SVazC0cRUW43
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/hwmon-Add-label-attribute-v2/20220105-231930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: i386-randconfig-m021-20220105 (https://download.01.org/0day-ci/archive/20220108/202201081730.TlHZabuC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hwmon/hwmon.c:851 __hwmon_device_register() error: uninitialized symbol 'hdev'.
drivers/hwmon/hwmon.c:854 __hwmon_device_register() warn: possible memory leak of 'hwdev'

vim +/hdev +851 drivers/hwmon/hwmon.c

d560168b5d0fb4 Guenter Roeck    2015-08-26  745  static struct device *
d560168b5d0fb4 Guenter Roeck    2015-08-26  746  __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
d560168b5d0fb4 Guenter Roeck    2015-08-26  747  			const struct hwmon_chip_info *chip,
bab2243ce18978 Guenter Roeck    2013-07-06  748  			const struct attribute_group **groups)
1236441f38b6a9 Mark M. Hoffman  2005-07-15  749  {
bab2243ce18978 Guenter Roeck    2013-07-06  750  	struct hwmon_device *hwdev;
57dab49995d01d Paul Cercueil    2022-01-05  751  	const char *label;
d560168b5d0fb4 Guenter Roeck    2015-08-26  752  	struct device *hdev;
44e3ad882bb268 Akinobu Mita     2020-05-04  753  	int i, err, id;
ded2b666156130 Mark M. Hoffman  2006-03-05  754  
74d3b6419772e4 Guenter Roeck    2017-01-27  755  	/* Complain about invalid characters in hwmon name attribute */
648cd48c9e566f Guenter Roeck    2014-02-28  756  	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
74d3b6419772e4 Guenter Roeck    2017-01-27  757  		dev_warn(dev,
74d3b6419772e4 Guenter Roeck    2017-01-27  758  			 "hwmon: '%s' is not a valid name attribute, please fix\n",
74d3b6419772e4 Guenter Roeck    2017-01-27  759  			 name);
648cd48c9e566f Guenter Roeck    2014-02-28  760  
4ca5f468cc2a0b Jonathan Cameron 2011-10-31  761  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
4ca5f468cc2a0b Jonathan Cameron 2011-10-31  762  	if (id < 0)
4ca5f468cc2a0b Jonathan Cameron 2011-10-31  763  		return ERR_PTR(id);
1236441f38b6a9 Mark M. Hoffman  2005-07-15  764  
bab2243ce18978 Guenter Roeck    2013-07-06  765  	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
bab2243ce18978 Guenter Roeck    2013-07-06  766  	if (hwdev == NULL) {
bab2243ce18978 Guenter Roeck    2013-07-06  767  		err = -ENOMEM;
bab2243ce18978 Guenter Roeck    2013-07-06  768  		goto ida_remove;
bab2243ce18978 Guenter Roeck    2013-07-06  769  	}
1236441f38b6a9 Mark M. Hoffman  2005-07-15  770  
57dab49995d01d Paul Cercueil    2022-01-05  771  	if (device_property_present(dev, "label")) {
57dab49995d01d Paul Cercueil    2022-01-05  772  		err = device_property_read_string(dev, "label", &label);
57dab49995d01d Paul Cercueil    2022-01-05  773  		if (err < 0)
57dab49995d01d Paul Cercueil    2022-01-05  774  			goto free_hwmon;

"hwdev" not freed on this goto path and "hdev" is uninitialized.  Sort
of related bugs.

57dab49995d01d Paul Cercueil    2022-01-05  775  
57dab49995d01d Paul Cercueil    2022-01-05  776  		hwdev->label = kstrdup(label, GFP_KERNEL);
57dab49995d01d Paul Cercueil    2022-01-05  777  		if (hwdev->label == NULL) {
57dab49995d01d Paul Cercueil    2022-01-05  778  			err = -ENOMEM;
57dab49995d01d Paul Cercueil    2022-01-05  779  			goto free_hwmon;
57dab49995d01d Paul Cercueil    2022-01-05  780  		}
57dab49995d01d Paul Cercueil    2022-01-05  781  	}
57dab49995d01d Paul Cercueil    2022-01-05  782  
d560168b5d0fb4 Guenter Roeck    2015-08-26  783  	hdev = &hwdev->dev;
d560168b5d0fb4 Guenter Roeck    2015-08-26  784  
239552f495b91f Guenter Roeck    2016-10-16  785  	if (chip) {
d560168b5d0fb4 Guenter Roeck    2015-08-26  786  		struct attribute **attrs;
b2a4cc3a060da0 Guenter Roeck    2016-10-16  787  		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
d560168b5d0fb4 Guenter Roeck    2015-08-26  788  
d560168b5d0fb4 Guenter Roeck    2015-08-26  789  		if (groups)
d560168b5d0fb4 Guenter Roeck    2015-08-26  790  			for (i = 0; groups[i]; i++)
d560168b5d0fb4 Guenter Roeck    2015-08-26  791  				ngroups++;
d560168b5d0fb4 Guenter Roeck    2015-08-26  792  
3bf8bdcf3bada7 Guenter Roeck    2020-01-16  793  		hwdev->groups = kcalloc(ngroups, sizeof(*groups), GFP_KERNEL);
38d8ed65092ed2 Colin Ian King   2016-10-23  794  		if (!hwdev->groups) {
38d8ed65092ed2 Colin Ian King   2016-10-23  795  			err = -ENOMEM;
38d8ed65092ed2 Colin Ian King   2016-10-23  796  			goto free_hwmon;
38d8ed65092ed2 Colin Ian King   2016-10-23  797  		}
d560168b5d0fb4 Guenter Roeck    2015-08-26  798  
3bf8bdcf3bada7 Guenter Roeck    2020-01-16  799  		attrs = __hwmon_create_attrs(drvdata, chip);
d560168b5d0fb4 Guenter Roeck    2015-08-26  800  		if (IS_ERR(attrs)) {
d560168b5d0fb4 Guenter Roeck    2015-08-26  801  			err = PTR_ERR(attrs);
d560168b5d0fb4 Guenter Roeck    2015-08-26  802  			goto free_hwmon;
d560168b5d0fb4 Guenter Roeck    2015-08-26  803  		}
d560168b5d0fb4 Guenter Roeck    2015-08-26  804  
d560168b5d0fb4 Guenter Roeck    2015-08-26  805  		hwdev->group.attrs = attrs;
d560168b5d0fb4 Guenter Roeck    2015-08-26  806  		ngroups = 0;
d560168b5d0fb4 Guenter Roeck    2015-08-26  807  		hwdev->groups[ngroups++] = &hwdev->group;
d560168b5d0fb4 Guenter Roeck    2015-08-26  808  
d560168b5d0fb4 Guenter Roeck    2015-08-26  809  		if (groups) {
d560168b5d0fb4 Guenter Roeck    2015-08-26  810  			for (i = 0; groups[i]; i++)
d560168b5d0fb4 Guenter Roeck    2015-08-26  811  				hwdev->groups[ngroups++] = groups[i];
d560168b5d0fb4 Guenter Roeck    2015-08-26  812  		}
d560168b5d0fb4 Guenter Roeck    2015-08-26  813  
d560168b5d0fb4 Guenter Roeck    2015-08-26  814  		hdev->groups = hwdev->groups;
d560168b5d0fb4 Guenter Roeck    2015-08-26  815  	} else {
d560168b5d0fb4 Guenter Roeck    2015-08-26  816  		hdev->groups = groups;
d560168b5d0fb4 Guenter Roeck    2015-08-26  817  	}
d560168b5d0fb4 Guenter Roeck    2015-08-26  818  
bab2243ce18978 Guenter Roeck    2013-07-06  819  	hwdev->name = name;
d560168b5d0fb4 Guenter Roeck    2015-08-26  820  	hdev->class = &hwmon_class;
d560168b5d0fb4 Guenter Roeck    2015-08-26  821  	hdev->parent = dev;
d560168b5d0fb4 Guenter Roeck    2015-08-26  822  	hdev->of_node = dev ? dev->of_node : NULL;
d560168b5d0fb4 Guenter Roeck    2015-08-26  823  	hwdev->chip = chip;
d560168b5d0fb4 Guenter Roeck    2015-08-26  824  	dev_set_drvdata(hdev, drvdata);
d560168b5d0fb4 Guenter Roeck    2015-08-26  825  	dev_set_name(hdev, HWMON_ID_FORMAT, id);
d560168b5d0fb4 Guenter Roeck    2015-08-26  826  	err = device_register(hdev);
ada61aa0b1184a Yang Yingliang   2021-10-12  827  	if (err) {
ada61aa0b1184a Yang Yingliang   2021-10-12  828  		put_device(hdev);
ada61aa0b1184a Yang Yingliang   2021-10-12  829  		goto ida_remove;
ada61aa0b1184a Yang Yingliang   2021-10-12  830  	}
d560168b5d0fb4 Guenter Roeck    2015-08-26  831  
1597b374af2226 Guenter Roeck    2020-05-28  832  	INIT_LIST_HEAD(&hwdev->tzdata);
1597b374af2226 Guenter Roeck    2020-05-28  833  
c41dd48e21fae3 Eduardo Valentin 2019-05-29  834  	if (dev && dev->of_node && chip && chip->ops->read &&
d560168b5d0fb4 Guenter Roeck    2015-08-26  835  	    chip->info[0]->type == hwmon_chip &&
d560168b5d0fb4 Guenter Roeck    2015-08-26  836  	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
44e3ad882bb268 Akinobu Mita     2020-05-04  837  		err = hwmon_thermal_register_sensors(hdev);
74e3512731bd5c Dmitry Osipenko  2018-10-24  838  		if (err) {
74e3512731bd5c Dmitry Osipenko  2018-10-24  839  			device_unregister(hdev);
792eac18431967 Guenter Roeck    2019-06-06  840  			/*
44e3ad882bb268 Akinobu Mita     2020-05-04  841  			 * Don't worry about hwdev; hwmon_dev_release(), called
44e3ad882bb268 Akinobu Mita     2020-05-04  842  			 * from device_unregister(), will free it.
792eac18431967 Guenter Roeck    2019-06-06  843  			 */
74e3512731bd5c Dmitry Osipenko  2018-10-24  844  			goto ida_remove;
74e3512731bd5c Dmitry Osipenko  2018-10-24  845  		}
47c332deb8e89f Linus Walleij    2017-12-05  846  	}
bab2243ce18978 Guenter Roeck    2013-07-06  847  
d560168b5d0fb4 Guenter Roeck    2015-08-26  848  	return hdev;
bab2243ce18978 Guenter Roeck    2013-07-06  849  
d560168b5d0fb4 Guenter Roeck    2015-08-26  850  free_hwmon:
3bf8bdcf3bada7 Guenter Roeck    2020-01-16 @851  	hwmon_dev_release(hdev);
bab2243ce18978 Guenter Roeck    2013-07-06  852  ida_remove:
4ca5f468cc2a0b Jonathan Cameron 2011-10-31  853  	ida_simple_remove(&hwmon_ida, id);
bab2243ce18978 Guenter Roeck    2013-07-06 @854  	return ERR_PTR(err);
bab2243ce18978 Guenter Roeck    2013-07-06  855  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

