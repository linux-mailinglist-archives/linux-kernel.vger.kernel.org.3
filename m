Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A904CCA09
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiCCX3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:29:47 -0500
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9CC107A80;
        Thu,  3 Mar 2022 15:28:59 -0800 (PST)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223MA1B0021724;
        Thu, 3 Mar 2022 17:28:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=DtV3nTYtmS2I7TK/P+AtMJK8z3lpD/GzHbL8Hp5sJvk=;
 b=wwmczID26tVWe8/xBgo2FfpNSwsPnWUWGWoqVUdB4rtZ8+dIMCdtc6FHHUzr32DB2M2L
 pQbAFVjr/NMKyrzVwz45StBN6d46jkUji2wz6e6SoYOCgIeAIRFTfozFgXM9zBIjw+nj
 8kyQPjR65O6UJpQ90bUoV26ahdXimqsGfuGwjNs675+6iMHypyvR7oBoGIuqGWu8K7sd
 BG7DcbdlvR3kMLn4Kmyoj2DihD6xpXVfzPeggNxiUSFS5yYJDqQzhC7q6bOMaHMDywXT
 YS2GWYYeIcx8I4QVcAvWpLnwsbHp2B1qOsga6A84lzy29y2w2FG/enj9SghcuI6EI+V+ cQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3ek4kbg8hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 17:28:58 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjoIh3Pj8uDe+ysPPCQNVtAuUspLy7KZAbwnwPoafgjbRTQ76+fu2YfB2xiNf4E0st2OQVhi8DdFY9DUbPurQniPUIGOhg1k5slskoBRpDh28NkofkSgDgrCVMSf0MPNrDLii8VLDk/rbhCPdgakLEktZwYL8CiULaG4iAExpNzf1T36h60Y1QtouMYR2L8o08fxvUOnBShjXKN9GqGCSKjL7Kpiov236jVebSgh/RlMdjFi3W/L8xlTMy5J1u3nshsWoJuWLjGeX36KB8OonrS2OQLwe/BNUgXz7zYpMWMpougFkKC7gZAZQwbbg/3v+vZft4Arj/36VJPV8PKf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtV3nTYtmS2I7TK/P+AtMJK8z3lpD/GzHbL8Hp5sJvk=;
 b=GFrSoEOhE6F0sEzw6Zv6ORlfoPqsnjCJl1f5C3/5EDaqN7/EXFb3CUn5EIvobqI6MdgkiI+D/ZiKYwvoI7AxUhO7jrdEn4Ju9Qn3+zXf74R4YKW0Z70j47ksz3oWITmm4JAZayIpk3lQoHePezDTy85GPiemdGuC99WJMZZ1DKYxAddQUtzmz4QObJZZ88nCo8xshz/CtMEmqs8j7j2K4Gex9W7H8MLlE0yylB9SKs1EUMfiQpxCZvM/aXtqqMGV8vVSknv9tsdQZS+VFa0YPTS+VafgH/xXvenlJb27iJqVMyvXRtiSRxBl5y9Pv03LAAjOPuUfSR0aVT0mhD1kKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=temperror action=none header.from=garmin.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtV3nTYtmS2I7TK/P+AtMJK8z3lpD/GzHbL8Hp5sJvk=;
 b=g+ZsC9H/uGEuORZgrOzQiCI2XK0NEq4PvB1A6mr5mj10Vz6z2NIXeGq3YaNAKx+6+K8F9SnmueW/cze2i6kzOts3tf+VSBglYr/unKqZA5KYrqLRU+iS2qIst4T38eeAiR9Rr/wSbMIMEFtlW6TA541qY0jFvxhscsLowZca0mexKfjt+hEoatczN0vKI+eqga8h25IkRlW1ZPI2zb60KGQfQEFaJinOat2mAtUj5dv2m7tqPt/m3C4R1tsbsXncqBQleMtsgcxkLWYberbFEk/vIN2haj8FZ+Ad3+EsEuNGP3FYxtHefE7fQSW6JzbqcsK8P/vDHcl8zZxBDpbcYQ==
Received: from DM5PR18CA0072.namprd18.prod.outlook.com (2603:10b6:3:22::34) by
 MWHPR0401MB3610.namprd04.prod.outlook.com (2603:10b6:301:81::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 23:28:56 +0000
Received: from DM6NAM10FT035.eop-nam10.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::ff) by DM5PR18CA0072.outlook.office365.com
 (2603:10b6:3:22::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 23:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 204.77.163.244) smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=garmin.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of garmin.com: DNS Timeout)
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT035.mail.protection.outlook.com (10.13.153.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22 via Frontend Transport; Thu, 3 Mar 2022 23:28:54 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge2.garmin.com (10.60.4.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 3 Mar 2022 17:28:47 -0600
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:28:53 -0600
Message-ID: <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
Date:   Thu, 3 Mar 2022 17:28:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
In-Reply-To: <Yg9EmVAHpEpmnLok@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: cv1wpa-exmb1.ad.garmin.com (10.5.144.71) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d61f1c2-95c4-4211-48df-08d9fd6d94f7
X-MS-TrafficTypeDiagnostic: MWHPR0401MB3610:EE_
X-Microsoft-Antispam-PRVS: <MWHPR0401MB3610D530B62EE41DA3BFC990F2049@MWHPR0401MB3610.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QH46wf7sunhGQhfawMMnJf8vAwjyqz5v90RNftFnpqey4JPIHklYCXke5bD6tOS9+jX+IgLvefwU5pVbN0N9NpXG5s7TuDWc/PdcvkI8pr5S6reRHfCdaMpY8ZU70hXARQb6DYeWyOSRp4mrVBvKBBCEFECvjMyxVSzlCElYRjKmTcXts0LRa0IO4kyZpSSgvNxI5TOO6QRJnnxt5NErRrYSakBnwcUgx9i3+H1lQe5Fy5Zhj0WPina7Gz6zTus/l/K5Wxih5N8y2YzWLv3j10nJekGusM8HIik1qiOvqAYgUN/WHilhhdDYqGHTyMqhgWJP5nxQ/Zf8cjT6Jh+wcfHk9u7xNZaT7wU1eb561n5t7+R5Po0kplfs/hHxfICjRBOit2h73+A+r8W17LIs0fvGl75AAt0Pe8opXHGX98yYkJpikq2IrIcyRYYhaZ2mmXwoVdQYuc4uczFM6vQ0Vtte9pbcEBOW1yYa6klQcxMGJ6XdHdUu3EsTe71huOLTDop2JctFsOSTg4+mJpkQjSkSENOJQK4JTGU7HcQ350l6goe06RBLRkoaW9SMiSdztX6W86ymG62SCLZ6IKzAqm+AhDgwwtDWCc3ry3IbTLDAcfFDgpM9X1SASpEd6DTvTXpY7+acdq5yEyfa0P8kX9EyCEpSAfclv8cECXaQOfULxXpcjzSJXPFiG9EyL1xVD7Gn1KYcaU+MnUmlpnqUP9auhZJKUtKrKbDvF+Ombnnof3ZyM9iHbks3kgLVbe865DyY9xwa7H2bEmPXCkwTpPQEl+am0vVxKAN8Oa+VRgs=
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(40470700004)(36840700001)(46966006)(356005)(7636003)(63350400001)(36756003)(36860700001)(40460700003)(31686004)(47076005)(63370400001)(508600001)(54906003)(6916009)(83380400001)(426003)(336012)(4326008)(2906002)(86362001)(316002)(31696002)(5660300002)(16576012)(26005)(186003)(82310400004)(8676002)(70206006)(70586007)(2616005)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 23:28:54.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d61f1c2-95c4-4211-48df-08d9fd6d94f7
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT035.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3610
X-Proofpoint-ORIG-GUID: 3JR4tSXpZiOjOOci4d7k2Am7Njp--rXk
X-Proofpoint-GUID: 3JR4tSXpZiOjOOci4d7k2Am7Njp--rXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_14,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203030108
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

We would like to take a step back and describe our application in more
detail. We are supporting global physical keys on devices such as boat
steering wheels that will interact with multiple marine navigation
displays on the vessel. Could you please provide some further
suggestions based on our requested keys and the description below.

Our marine displays usually show a single fullscreen application which
may show multiple types of data at the same time. For example, the
application may be showing a map, RADAR, and some media controls at the
same time. There can also be a control bar at the bottom of the screen
giving options to do things like return to the home page or open a menu.
Multiple network-connected marine displays can interact with each other
to share a single keyed input device across them. In this setup, there
will only be one active focus for the set of those connected devices.
For multi-display setups, the focus can transition between displays
either through the use of dedicated keys to immediately move the focus
to the previous or next display or the focus can transition between
displays automatically (e.g. when the user requests to move the focus to
the next element but we're already at the current display's last element
we will move the focus to the first element of the next display).

For the elements displayed on a single marine display, our UI supports
grouping them together into containers which function somewhat similarly
to a group of radio buttons in a more-traditional application. We would
place the previously mentioned map, RADAR, media controls, and bottom
bar each into their own container. Containers also get used for things
like menu pages where we have a list of items to scroll through and a
separate list of buttons that can be used to take actions on the
currently selected item. The focus can move between items within a
container by using keys like up, down, left, right, next highlight, and
previous highlight. To make navigating between these containers more
convenient, we have a focus key that moves to the next container. This
focus key behaves similarly to the tab key with a traditional
application that has multiple sets of radio buttons, but we also have
support for embedding traditional keyboard input into one of these
containers where we would need KEY_TAB to behave normally. Our focus key
does not change the visibility of anything on screen, which made it feel
a little different than the description of KEY_CYCLEWINDOWS from the
video remote controller documentation
(https://www.kernel.org/doc/html/v4.9/media/uapi/rc/rc-tables.html), so
our initial proposal avoided repurposing that event code.

 >> +/* Toggle the focus in or out */
 >> +#define KEY_FOCUS_TOGGLE        0x27b
 >
 > Could it be served by KEY_SELECT?
 >

We have a select key on our marine display which is used for actions
like to select/press the currently-focused button or behave similarly to
a left mouse click when moving a cursor around on a map. We'd planned on
using KEY_SELECT for that since its proximity to KEY_OK made us think it
was intended to confirm selection of an item rather than to select the
next item.

In our application, the focus key will move between containers on the
same display, but we felt it was different than KEY_CYCLEWINDOWS or KEY_TAB=
.

 >> +/* Move between highlightable items */
 >> +#define KEY_NEXT_HIGHLIGHT        0x27c
 >> +#define KEY_PREVIOUS_HIGHLIGHT        0x27d
 >
 > I wonder if KEY_NEXT and KEY_PREVIOUS would be suitable for your
 > application.
 >

KEY_NEXT/KEY_PREVIOUS seemed to be designated as media-related to
control chapters in the remote controller documentation, so our initial
proposal avoided repurposing those event codes. We anticipate needing
keys for next chapter/previous chapter to control our media inputs in
the future, so using KEY_NEXT/KEY_PREVIOUS for highlight movement now
could lead to conflicts for us down the road.

In our application, the next/previous highlight will transition the
focus to elements within the same UI container.

 >> +/* Navigate Displays */
 >> +#define KEY_NEXT_DISPLAY        0x27f
 >> +#define KEY_PREVIOUS_DISPLAY        0x280
 >
 > I am not familiar with marine navigation devices, could you please
 > explain a bit more about displays you are navigating. Are there separate
 > physical screens or are there several application screens/views you are
 > switching between?
 >

Correct. These are separate physical screens. These keys would
transition the current highlight between separate physical screens that
are located next to each other.


 >> +#define KEY_BRIGHTNESS_MENU        0x28c
 >
 > Do you have multiple menus in the application?
 >

Our marine displays do have multiple menus. This physical key will bring
up a menu to immediately adjust the display brightness. Our displays go
extremely bright and extremely dim to support outdoor use during the day
or at night. This physical key can be used to quickly adjust brightness.

Thank you for your assistance.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
