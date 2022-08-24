Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9759F89B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiHXL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiHXL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:28:56 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960780037
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBRlkcAqySf1cN3ee8p1GCyFr3FGeiJzYNHRYe0jNKl2CUm9t3HdIgw5Fhv8sboBOofux2VS3qQZlil1XJihQffhcSwsXh9+p+D2GZ/Lp7Tt61ciV0wsB9CFJTUpchieebyQYmdnaKlD2iQ9NKLfxrkXx3ewfISMu35p5Mkstbmu0QKTRP9zNHptNpbA4b2h5UUQ24Ys2hPKRMtR3OA+ciWVjMMpLgSFb00AsQpc5juwxeOEGYdR2QIJfZFIENEA3zqXtPgfmxfX6MuqRXoIjIxyDhFTsw+wgjHNBJDtWVdxklI7xyzE+7uyNz5Zq41kkYhDq1/ws9BXbapd8/z3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kGhiRNnc8+0b7Jf3OCazqyOSxIb/8Ute+4gv6wQQZU=;
 b=OotzuX+tHgM0/CJLvz6AZqnBEwB5mPTqITOR+jDRMmaBATGkhleX0B5Kn8ngcUCUSnTfoPEq12AIJJcPtC4em1+GHs7yN37fDBYHtXyssfEy4ibWDm0GvfrV2XBlnLY+agb01v5PPwP/ZQ3O5lIFc0alOjy3t3xMAP0Es0ZWNj8XH8JGxYRcJlsvCemH/FbuUU/FbqLlohKcCy7mbiiU7ZMcYb7R3Hq5252OuLQL+BLGyxvbpapHQG8xy63tSxCKSJy0zJ15jmmWjJ9zl5CMCr3X6knrzBxmKp9IdY26Pgz6u6VVe5c7Sefb3WGyNKPAUBQ6DW4SomXgBR8R3Qzwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kGhiRNnc8+0b7Jf3OCazqyOSxIb/8Ute+4gv6wQQZU=;
 b=CgfWFZUeLsn6UmScVk89buQbHJBiqRUx6RfCD+xkcaKVTBp0Q/o8Gguay7uzvopawzdoMJWqMj8YxGtdtTtmtx/PEcBHVQ471cBPn/l91IRwakBQD1wjLcITt6QAih3j2tKD27cL4dL5omjzrYm0VTihhmx3ez005moKSEmlFETQfJoRtLqghWAp9NrN3tS3Ygf7ET7qebHskxSKnnMqeM/JeVWclPmwG5hEnj1JLVtFABzGXHY8BgQmN4Nzhee/GBbjDLgMfPHF6cjGhkJ5qRsAMmUbPRISkDEmc1neosp3Lc/gGgAFlPIMZ2ldy4twRU2lLxXCLJ5g752jxKd3ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by VI1PR04MB4894.eurprd04.prod.outlook.com (2603:10a6:803:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 11:28:51 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5546.021; Wed, 24 Aug 2022
 11:28:51 +0000
Message-ID: <369a74dd-e357-a352-fb17-fa5aa3726e0e@suse.com>
Date:   Wed, 24 Aug 2022 13:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220823174158.45579-1-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20220823174158.45579-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1eb59c-21e0-4804-be75-08da85c3d205
X-MS-TrafficTypeDiagnostic: VI1PR04MB4894:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw2PKukbAM+k0nbGsyK+Dz4miA8PBtJE94NvLcOjyuqDHckGn9OcqaWIcuvxayPk9OjarnhjAsydQViqSAMkVhRweDabWbMJURXX3CQOYP9HRQma/iJFGfCE2tU06OGwzSivdCbzZVLp/9tWKZMZ4zbSPQXNgJ/GcL+WXAC4hTopqu2LwDPHvc+mykYWE83ivD4bZNYnQA2WZ+Cn+Z4hNAtvzDRE1TZ+r/XuQ8KCwCRNgXVx3pIS2xAXvns37OI58mvZOB+xVafPGanjZBkhQSu+C9an1XVl3I1WLNQkujVrIXEkbmKDZRGl187sy1wi8Zvc6rZ+DRkguhNU77TDqe1YZ/kBBAi18xmgieSsGKCKZ/MEMFU44b1y/5ijrXxhLPg0gGtK9Dup8UaOgxATDdBQxYsa5mv4TZuCxQQhSY1WUG+9unKqZL+Ge0ad2N7pUIjJFF7gpJWApd6gx6BJHnJheYnZpDyu1VEQNIQwY1CbP8QnKB1V9sjte5+XUJqLKQCSw3IulTfbQahdpS66ve3gyzjrS4plKw0YlbwLiDiGCmZ7WlSjjN54pmKh0ec8ncCX+RqmzCLSvN8qHFeIjqiApFq4DkeFKI3yZX3/mD6Pcy/554gCHrCRAQt61dsW/EmiztKraNjJJPX3rt5xBW6L5TlJ0MKxlBUYiHODe/gmhQF3t6g+KVtd7XmQRPrvry5UZ5zA1wkGet2n9PDoy3ri/uyoiXotinYAVj5JvN2ds6BQVe8gDKBkQ+xJuw/knuPm7kZR6cXfGld6/NrfBv6C24PJ27wS0UyDVPuD5T34FA80T92QFseAy0Urtb9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(136003)(376002)(366004)(478600001)(6486002)(5660300002)(31696002)(966005)(2906002)(7416002)(86362001)(8936002)(31686004)(36756003)(66946007)(4326008)(2616005)(66556008)(8676002)(316002)(6506007)(66476007)(53546011)(6512007)(26005)(38100700002)(54906003)(41300700001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUd4d2lKV0tkM2tZZEFHSk81NEZoa3MzeEZUMm5sMWdFNWpOSnN2ZStVanM1?=
 =?utf-8?B?cjZzbTE5c0RiOTVUVnlQS2NUWDVmd3h1WUlrLzU1Y3RWdnZaV3NFbnVQbmdk?=
 =?utf-8?B?dnpsQXkwUnh5a3N0UzlIYy9pcWdZY1Q1eTdqSGdYSHNhNlhFOEpaM0l0YVRK?=
 =?utf-8?B?Z0dmVlFmL1lzOElYY201ZG9uQjZFY1dRVWZrUWplNDV3MWJpbEpEQTBnRkVh?=
 =?utf-8?B?WENzMTQzRUh3TzJjTE1WNWZSTkM0eUlZUzVLNWx0bGlWZ0IvV2prd3NPMStK?=
 =?utf-8?B?bS9UK29RMzI0QVlFb0FhZ3A2Rm4zYUU2MFZDZHZ6cXpFS2hOMXh2T3RYWjRG?=
 =?utf-8?B?V1Y0aVBoNHFSemRSd21jcTVGb2tvM0x2aW9zd0h5MS9wZTcrME12RVBIcTRC?=
 =?utf-8?B?MkUzUC9wY3NIUkZYZWlTcmluaUYveEhkbWNBSHNhcWdhTGlhYndoL2pQdDcz?=
 =?utf-8?B?L2xoZkEvRWFqdXdPMjVNRkxDWWM3T3h3aFZwWWQ0N1dXa21QMU9ySDBjTDR0?=
 =?utf-8?B?MW0rQTdhNi9iTDFTN1o4czN1cm5QaFd2SElLUG0vT3ZQVDVkK3FacXQrbk15?=
 =?utf-8?B?bnIwYjRsZlZkdS9QNEpHbkxENHdVL2lsTXZLTmFvckJMR0lZODd1UjU4Q0hk?=
 =?utf-8?B?UjVnaHJzRlkzdFlnOFh5M0x4MUoyMnVySGxxYWxSUW1VMm96U1c1azROTytY?=
 =?utf-8?B?OCtyQk4wdHJaTm8wb2Z2dzJGVDI2OThhNHlwSXIvZmsza2hmQ3pYYmcrTy8z?=
 =?utf-8?B?REF0RStGNmkyRngrY2dpSG9vOHJjb3Q1MlRaNGFPQ09rYkhuOUROZzBabGw0?=
 =?utf-8?B?QW9pVnhId2NadnBma3hycU82TTFyVFZVNEVtamJEWm80bmtBa1Y2amVoTlNC?=
 =?utf-8?B?T2ZsajJSQWk3WXJXeXlUdnRIQjhGRTcvK0R1T1pXTGhtTi9ubG91VGxjUmF2?=
 =?utf-8?B?VEEzWFJxaVVpcjRYTFRmcHQ2RVUva0J6ZjhUdWgrUld2TFdSTWw2WWVEWUxq?=
 =?utf-8?B?eE94Y2JiTlFxczFuR3VWZmhpMnVrWmhqdkpnWkR5Tmc0TFVQY2tERjJoMkdR?=
 =?utf-8?B?ZTBFSHZTaHVUZ3UvaUtLUm1nRWFzVXdXeWk3ZnVBTzNoWVJWT0lqRmIvQU1B?=
 =?utf-8?B?am5YZ2VEVS9uMXpqbGo0NU5uWUo0WDBpSEhxaFpnSUtiaU1PR1B3cUQ4VkhY?=
 =?utf-8?B?ZEVKMFg4aEJac1JlNEFrUTJ2QXlMTDdJMHN5Q0VjTTB2YkdwZ3Y1TVN3UFEx?=
 =?utf-8?B?NEN5QS9XdmluK3RIK0hoamRMVXFHR1kwSHNSUnk0TmhLS1R3dUVLRG80dGFi?=
 =?utf-8?B?azlKcjdleHZab3NzeFZRc2JwZGJmQVJ4aGI5aXlacHBBYW90ZWc1RVFGWGpr?=
 =?utf-8?B?TUdRR0p0SWlkN3NqR1VqMkplRzJIUFBhNzg2KzlIUW5NQnRzam1qbGVyZWI1?=
 =?utf-8?B?SnA4b0grQzBqaW0xc1QrR1pZeVJwMGdYcm5ybWYyaWpUemZ1YmF0SWlXMUgz?=
 =?utf-8?B?RDRkZGpOMDZMQmUxQ256NDBiNnhMMEF3VGJ5SWsvUjJlWDNYT3VtSkJzSVor?=
 =?utf-8?B?TkVUSTlXY2V2OXRHVUJON2dscHNzbVNLNkVUM3RUdzZGci9RN2FPdmdTZjBD?=
 =?utf-8?B?aEZ3QS94QlQ3dWN5RWMrSmIycmxXczNpanZqT1Z5RnV6U0trSzlXaGVickpM?=
 =?utf-8?B?YjYrQmNobWdmUFlhUkM0VExxQlhNbTRjdGhKVUpucHFweU9KNndjUnRPNE1F?=
 =?utf-8?B?cFNxZTMxWmZvWExjekVrbldDTjdxK3J3Y0hhcEhiSTFtcVVYRmJhV2dZa1hU?=
 =?utf-8?B?T3orS0FuU2NkVysyQVJZamdDeDZMQmtzYkFFQmZhMEhCa2tvQ1lUTmNpOW5v?=
 =?utf-8?B?K1BsYlNRTStIRW9oWVRvV0VBcUg0b3FYYmtBN3A5M0hTdFpLTHFjSFBDR1NT?=
 =?utf-8?B?OVNaaTQwMXNoS2xEamkxMm9ZS2xBY2pkU29BU1lUZmNGSkJjSnRHc2RBclBE?=
 =?utf-8?B?ZmlUb1R2YWhpbGp4SkhGdG8zVE4yMG9lNGtVSUpDVDhVYko4enl1SVNxeHYr?=
 =?utf-8?B?REJyRFFtaElhdURudGE3UVdNSzV3a3p5bDJGTjh2REtXbDFGT1krUTN6dnVH?=
 =?utf-8?Q?WHBS7oMsjIpasOsI8JzkX0hx8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1eb59c-21e0-4804-be75-08da85c3d205
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 11:28:51.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76jr5jB9+aCwMye9JeBSn409XqsCqg9xk95OM8Hx3F+9Q50nsi+lm6nCo+SrvO5KRf4z72d5eeTA4x4f4CBZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 19:41, Charles Mirabile wrote:
> This patch series adds a set of drivers for operating the Sense HAT
> peripheral device. This board is an add on for the Raspberry Pi that is
> designed to connect using the GPIO connector and communicate via I2C.
> 
> It features:
> 	- a joystick
> 	- an 8x8 RGB LED matrix display
> 	- a whole bunch of environmental sensors with their own drivers
> 	  (those are already in upstream Linux)
> 
> This is a refactor of the work of Serge Schneider, the author of a
> version of this driver that is currently in the Raspberry Pi downstream
> kernel. We modified his code to make it suitable for upstream Linux.
> 
> A couple of tests are available for the driver in the test folder in
> this repo: https://github.com/underground-software/sensehat.git
> 	- sensehat_joystick_test logs the input events from the
> 	  joystick to the console
> 	- sensehat_display_test displays various solid colors on
> 	  the LED panel.
> 	- full_sensehat_test displays a single lit cell that can be
> 	  moved with the joystick. Pressing the joystick ends the
> 	  program.
> 
> For more information about the Sense HAT, visit:
> https://www.raspberrypi.org/products/sense-hat/
> 
> Changes since v9:
> 	- The driver for the sensehat joystick was accepted upstream so
> 	  it is no longer included in this patchset.
> 	- Some of the people involved in the development of earlier
> 	  versions of these patches are no longer involved in the project
> 	  so they have been removed from the list of maintainers and the
> 	  patches.

I'd would expect the patches to honor their involvement in the past, but if they 
are fine from being dropped, I will not object...

Regards,
Matthias

> 	- The code is completely unchanged and so based on the discussions
> 	  from version 9 of the patches, it should be ready to be merged.
> 
> My appologies for the long delay between v9 and v10 especially given the
> fact that there are no changes to the code. We appreciate the maintainers'
> patience and guidance throughout all 10 versions of this sensehat patchset,
> and we are excited for this driver to hopefully be fully accepted.
> 
> Best - Charlie
> 
> Co-developed-by: Joel Slebodnick <jslebodn@redhat.com>
> Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> 
> Charles Mirabile (5):
>    drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
>    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
>    dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
>    MAINTAINERS: Add sensehat driver authors to MAINTAINERS
>    DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
> 
>   .../raspberrypi,sensehat-display.yaml         |  26 +++
>   .../input/raspberrypi,sensehat-joystick.yaml  |  31 +++
>   .../bindings/mfd/raspberrypi,sensehat.yaml    |  57 +++++
>   MAINTAINERS                                   |  10 +
>   drivers/auxdisplay/Kconfig                    |   8 +
>   drivers/auxdisplay/Makefile                   |   1 +
>   drivers/auxdisplay/sensehat-display.c         | 205 ++++++++++++++++++
>   drivers/mfd/simple-mfd-i2c.c                  |   1 +
>   sensehat.dtbs                                 |  52 +++++
>   9 files changed, 391 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
>   create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
>   create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
>   create mode 100644 drivers/auxdisplay/sensehat-display.c
>   create mode 100644 sensehat.dtbs
> 
