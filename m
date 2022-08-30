Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED55A6284
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH3LzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiH3Lyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:54:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9584610A7;
        Tue, 30 Aug 2022 04:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx9I7QV3KvUOGUM2RYaCpruzSzNSHxIqdsnaMgKDMpfwz4aSZJsYugArJ76+/CwPiMQNyphMqEn3rhs3JmxH0allu4W5q6UO6LT4SnlcSLEhw1mRY/Gnspw25e3vef6dpxr7/IlIT+mJGHQQWE/3iz+wSH+fObDI6yvoi2WtL/qUBQc18z962TugOgSJZtoWqLAPx6hk/eYyscq48hYLaylf85TCCQt2VPOvP2bbtSPRyHZvhzCvjt0XIzKet1DHNKsNXLW4Ono3SIXujcgcYknPujV0MlYLCTHzddrXduWoQVzUTY9t0PPP7VkmLD6dI7S9F6Misoo0AiCbWl8XhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Nfo7WiGI/7gnvSct9EU5g9uSM+o9Qlx2zIWHlv4zZQ=;
 b=ZB5XlDEp3zG2w/j3KTJi4jp2RjtwKX5Q7GYATipQbt2wl3S7xeVUbnSOdv0Pzje3gesW8Y8LF5hyaJ3zBxcc7hbgMqarBX0dh8oJJm/rgbAH4bipgnAd23kMsYIK1TrdvWsMuq8wu0Bba3GN9DkzR7mSYr8Y1exJvAiSdH1QcqYsByL3IWwfs/qeSgOd5K+vuvVAHt1G0b0zELcQuShI2gyPCSlKTie6OV/bmIv+P8U3HYHsGE8AhG7picgr07nrMz81+fKssBsaEAgW5vyYK5vmGYpH8LDcfTLrhUWig1pbt6Zm1cPa4jASpJqOEwDtAKZKyWjP3xd/zTojidAapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nfo7WiGI/7gnvSct9EU5g9uSM+o9Qlx2zIWHlv4zZQ=;
 b=wB/ksOeEf+EwSTCAB5DHnkwyWFww4PbLDbSdEggHZ3Gc/FWaByBkKdVzELbpm8bQXPgkvOuBG8SC3WyPSJ1RX/DmHIYNi8xdqbeKKU+hyKYQJk31J2UOZFagww394/qNz77m8RNrM/nY6pPmzdIlZKqB8zw/LvbCyT38x3NmEUTyzYRBqazveDZe+iN3TfSDJ6N8LpH6aRc8H6ASYZgWGY+yC6wAHQmhnLqianvL2HyDO2PEiMV/ml7ezuNZAEZmhMefWMtvzmf0slo++FwZnKDvoDw2axr83pvOOV3UBmJtFEkMQz6tUwF+8ML4/Fze/zRaTCCYuBgOpMDNcu4vXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 11:54:45 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::b083:534b:70ae:416a]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::b083:534b:70ae:416a%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 11:54:45 +0000
Message-ID: <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
Date:   Tue, 30 Aug 2022 13:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Content-Language: en-US
To:     JFLF <jflf_kernel@gmx.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220824160946.10128-1-jflf_kernel@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d0b878-309f-4516-699e-08da8a7e6ea7
X-MS-TrafficTypeDiagnostic: VI1PR04MB7200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT6MRA6RK7q2gnqViOSbmiLpYltfrfxax4gu8vm2F+qfhKdck5Izirk8uT3TJQHSPRZNir1a3rYpWg390iuuZX0wQteoWnMbhRH01h4RGSIqBSQjfrWKVfhThwhQ8ZPwJ4jpCldjgBUWfsDW/hy782b08F86PidnHs+bomO+1CRIIxHDqWl5CKGmPIxMle0q48l+lRuKMXpY8UKO7wmA/NpdypYDNr+u1sNGm+uripYP0Rdf5XGnL3V4hY6nK8/u+xYDsEJQCORyz7tcdcdo49V838FHnpjgaHgPFLZCFFOMq7oEEesQvyY3IBQK6zE6BBDY+LvH/lCT/rVtAhIA2uv3bpOb5gj6VvPHwVDgA9amzrCPfXqVm/HQd7SwZGNwGBpKLjdWNBLOo6UjBGzzDBngfPp93jGOr9F3Jx08sM/MjqYSs1HqP9UhdyMTSARZvRUhzV9j8+e1kv0QEcX6ioiUc4tYSNtCKl9UEaGhgpLMnchpi8+hNjOwOsE0BH9E8osrTwvOHZN+uhz9m/ise9IjdbPs7QPSreglul9loolh1pjpXl+2zF6MqyvfRPoNNNS5t34nPh8berV5ktehJ00K3vjsJCECm0CSY+ICDue8aoecHy0/EDeksuSTvO3JtqCJfXntdpup7/RmBKwdVSTbo3y6TvaWelBpfCjvWJGU4QVmf3mm8SIokEOUnqOmTsT5OrI0yzHEOPafIETtoFLeJXYfRIcNZc75TaQZqlFvRwqcxo1DgHP+dy2qt+QSK+g5dRe+53+L0+Gh9PH8gZUR68duMoZON/QVep/GFks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(83380400001)(6506007)(41300700001)(53546011)(316002)(86362001)(478600001)(31696002)(6486002)(38100700002)(6512007)(2616005)(5660300002)(2906002)(66946007)(4744005)(186003)(8936002)(8676002)(66476007)(66556008)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhhWmdhK3hWQlFlUElNa3VYTzlFNDEyRTIzRmhkN1pVeXNpeDdxL3BwTUZu?=
 =?utf-8?B?bGtiZ0xLam5SQlE2eXhkVW45Z3hwdEd4T1NiaHh1Q01UUlZmYVlhMUR3WDJj?=
 =?utf-8?B?YjVwRVYwVGNQWjI3V0IwWGY5WGx2TTZwVHJRSktIVGZxODluZFU2RUhKOFlO?=
 =?utf-8?B?ZWFoQWR3VStJUzVIOW5GQTArdk9nUm5Fd2xLelh1cmdseFZtaGI4TEg4MlZW?=
 =?utf-8?B?aE1JZnJmVVJ3eXdIRjZFUENMeHdNU1lHeE1jcTZzM2hBWlEzN2NpRTZGVmhu?=
 =?utf-8?B?RzI4OStEa28wY1lwMjNWQWNxazQ0TGIxN09MRmRhdGpLU2lsamFJRVkvYzVv?=
 =?utf-8?B?cE1YNmtGSWRpSGVtVzZScXZGT3FFSnN0ME1GSWYyRXhXbGpwRHVTUGI3MjRU?=
 =?utf-8?B?TXhTNXNZZy9FelZFZnFidHNJejdnTVVKdGp5amd6dVlCVU9pVWZJZU1RbEJo?=
 =?utf-8?B?dTB1aFB6eGMvQkM3djVoZDl6THNaOTJQeGhQNGY1Y2xyVWR1QmVBcjFTdmNv?=
 =?utf-8?B?eEgvWmZvemVITU1vcDduRHRYUjBKZjV0QTc5YVFzV05Halh2QVV5UU1lWU1z?=
 =?utf-8?B?MUcwbjJnSW9ER0tBd0NmU3orS001ZWJZUVhCWDQ1KzI3VHZtV2puSkZPd1lh?=
 =?utf-8?B?NWgvY3ZqWHpST3NDNVVRSk1Td1R1VFExK0RreWNtTHBCMURjbVVNb0p2RHgy?=
 =?utf-8?B?V2hzbnBQMDVRbjh4OTk5ZXNBcFFab0paUDl2REdRUWFoY2xRd2xRcHhrajZU?=
 =?utf-8?B?RXlXTnp0N2MzMExYamkwdG1UZUNJdkVHcFN2Z08zbDJ4d1Jyd0YrZ1JuZVRv?=
 =?utf-8?B?alpOOEdBdnFVWnM5NUdXdSt4emxHdVZhQlBYUVJ3cGdUdzB3ZGJBNHhxeDBZ?=
 =?utf-8?B?Rjd1MjNTVHhDK0dveHhQM0NtSG1RQzVmdjJJenBHTHcrRThFdTJ3aHByd0dO?=
 =?utf-8?B?Q3NsZVEwL041MGVoTVlYTFU5M29DWTAvZjVnT0c5eDJ3eGtKUVVYZkhhdWtC?=
 =?utf-8?B?d0V5WmpscDJPVkh0RCtlOElyN1ZWODhmR25LazJHSHFZQUNxd3crM3R2NSti?=
 =?utf-8?B?Tk1QWUxSM0tHVmEzcjJGbHg1aUxmRFp6YkV4N2F6YUFYOEdaUWJGTHRBR3Iz?=
 =?utf-8?B?eEorUm9SY3g0Zkl3aUJvRkwzZkxVZWdpaVc0YXlTNmwzb1c1Tm9HRENndy80?=
 =?utf-8?B?R1V3QU5Zd0NjM1NCaHN3NllDYlRwM2dUTC9POUYxSGYwK2xnVW55N0dwZzg3?=
 =?utf-8?B?V0F6VnAwYTdoZkVzRmc3MVZLMzErRTZvZmUvY3k4YVZWbEl5Z2ZQYWFVRnlz?=
 =?utf-8?B?Wm4yS0NpV3pQMVR2VGM3TTluK1JUaFJmclNub1FOaklrbEIvTXk2dGdLVUEw?=
 =?utf-8?B?Tk9obUFlY0NjNm9wSk1hMXdxOFdoVWQveUI0UHgzMVdicGp5UFJuQ050T3Nk?=
 =?utf-8?B?d2QzVHNkcXBTYStYN0dhdFRiQmZ1WDNyZUNCVWEwTE5Kcm0zbHJzZHBsVEVO?=
 =?utf-8?B?U3pmcVNiZURzUXlMU2djYU5EOHNKalpNcHVXckQwR0M0NTJranlBUm1QV0ha?=
 =?utf-8?B?MkxRVit3TGgwOVVQRzVvTlFiUXUvM1Z1dHByeU9XaHhjdlUvM2tpSFhhQ25a?=
 =?utf-8?B?NEM4ckJZQjAxME5NTU9WV2pEcEtyWmJlYWpkcVdyRU1HNjNaRitRdjQxaUNJ?=
 =?utf-8?B?VUlKeDlhNjB4UmFseDIwaDhnNVVwR0dPN0FSUTl5d3dhMHJKanZxblpQY2Ey?=
 =?utf-8?B?K3Y0MVBZNWpBZEtKNXF1cHUrZlFVSG1SeHVBZkFaY0NBeWhZM2VYNnJyZW14?=
 =?utf-8?B?Nllsd0xYUWZiY0NPcno5a1lTWkNwWjlpVlRKeDFRN0U3TEllVldEMG9RaUUw?=
 =?utf-8?B?ZkZmTmZhZmZWUGE0THNndnJ6ZmNlMmIyOFBlQUdxdFBJekxYTHBNWXdVL2hn?=
 =?utf-8?B?V0lvTDNiU2F1aFFiSG1yUGZ1TnU2L085eEUxaTNiL0RDMFczMCtmUG1BMndk?=
 =?utf-8?B?NEJqL0xpb0lDK2R0b29ha1BIc1JrQWZFa1lDSjNHK2xwTEw3NXdGaWJBVUlM?=
 =?utf-8?B?dEVhZEZaVjQ2SjhTRE1kQlFEMnNBS2YwLzF5cVdodGNVRU9MU2hvZWw0Ly82?=
 =?utf-8?B?ZUdqOEZMUXJnTmxyUHNNZDdlZ3hlTnVkcDREUGZKMTVJNVRaUTczbG50SmNp?=
 =?utf-8?Q?LxbTlCDD5eMzGgdz/737s7Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d0b878-309f-4516-699e-08da8a7e6ea7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 11:54:45.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDT0N8C75ESQuvptj1sPl+f8Q/SiVMjM2BJLlfWzQj8wvSLODxEY2+qTXxjCimL5Ux5n5pKiNxsTT9qYRCJT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.22 18:09, JFLF wrote:

> By process of elimination the controllers themselves were identified as
> the cause of the problem. Through trial and error the issue was solved
> by using USB_QUIRK_RESET_RESUME for both chips.

Hi,


aside from the aspects of getting this properly signed off and merged,
this opens up a question. What does resetting a hub do to its children?
That is if the request to wake up comes from a child, do we

a) lose state in the child?
b) retain the knowledge which port requested the wakeup?

How far has this patch been tested?

	Regards
		Oliver
