Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6C5A6694
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiH3Orq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH3Orj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:47:39 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2FB516B;
        Tue, 30 Aug 2022 07:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3tv/BkYWSJdxaxShFZrXmU7BRovETZlX7CEjzMe8XQS2gV/0k/I6RRewMiDoAmww++SDBri6eaQ5LlDNzihcW3x06Lj8z1NjPbZc1dgI4eRe7alTDIZzd5xE79srpbJ7dqCSJGrFWq3w+vOTvwQr2Wt21u0K0xo0vZrOEZ3XmFWQi53vGemEqdvPi1AiiHftkAck+kHI7OySb2LExJory+i7X7zs9dD1aFB/CprK0CXtbDfJnB5VWkvbrcjb7uIeZIvKqBCNjgxzepXT6aLngmWqMYgwkjg2nix9x+Rv49B3nO0rMAiou9iNKlBDqycgnJUoZvKTQmkKZ/O5GmnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glXmt84a9pR5LviSpN7oOF9cRQBDZVhmKCdDA2CzpZo=;
 b=IUMYF6oqQWBBYodm1rlWs+MPhgg6LCK3HUfOLQl8fDHeqGhZ7BZ7+aiX8MJoKuOsmQZsopWS50IATEvPGvwQcyz1dBok3H1clNypGDjCACfmVTskfzvkOCtuLqoFOnKhVcH5b6gcuMdt9LNV+vYi6GaOwTqruYqr/dttgtiuwZsE0FAfyT/tEc4VqUTNBEDDDRdCBAgSuJb6QF4HIaTRwc6Aj2WO2vHs/B8TQZajQDVk74r7k+QDJnJzDWVFuGNZJs091N8YQ6cWNB3PdWFlwehAoWXggft8R340JyIVE3yuWxhJy4JLuN6KBYU+NigV5g9bPW9NRqqOeASULmNPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glXmt84a9pR5LviSpN7oOF9cRQBDZVhmKCdDA2CzpZo=;
 b=nsczaHBzFxu2O+Ac8oEOPouqjSaJTtM07Nbiyw3MLdctjqfXb6ide1jpTUQMepEZKuKwNy8DQR+A60Cg+aByvgAs2NRG6DkWXMMwDGTHNvIIW03qOw5l52Wysw8SM6gAH7PVboyrXqGDTe4oOQMtx68uwhWl0a0E5XDTWdqxclpGp5nZJcV5AWkpPFUiC1Ahqf/i7pA+Btr3egniDueqTMAwhCWsHa1RCujTNR1ynLUTrCmQgunajrds0xvZ7cVIuQdR6/UuqTby6XeLw/ZwcA4yvl8gYizCbYvqdsD2I67cs2niFl55sGLYu2YNogoHmz7oD9blsztTsCyjbNBRiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB8PR04MB6747.eurprd04.prod.outlook.com (2603:10a6:10:10b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 14:47:32 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::b083:534b:70ae:416a]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::b083:534b:70ae:416a%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 14:47:32 +0000
Message-ID: <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
Date:   Tue, 30 Aug 2022 16:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Content-Language: en-US
To:     jflf_kernel@gmx.com, Oliver Neukum <oneukum@suse.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25cf67c5-cb6d-4b3d-6b88-08da8a96918b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6747:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rwzVzHxvBbGQOGb5n3WY4LCBiVHTELyS+FZ2+fCT+ZqRHDJGsDddvV4MSiFQSLQFn9Q1wWfS8pBMGSHiyE0J9WnnDVaWAAUCQz5X6R2xMqfHZAq1jmEjCEGAfAInyYBDLiaLPEn+Zl5IVbUjxDr2xQDNfKhZ2tmOH/Mgq4S++12Z0ILRyYpp9NNhkUYBNSred6cBI2za12eb1ECkP7Z4M8KAcBva4flBwEAjB28JkkkRWzG3z1k7Q9qlH11Ui5BsEFcQXTlv7FWQxF5gm9pK8Mh6jKYCLN35n4zihBxXdaXBBSjCWwx8ZxI9euAU1ENsxsMpx7Wyd7WG6/gJJzjEaCEfssLBWffrR2QrWjgyMyQwDxsZKpbtebWDlKPPCtWJxmQxwRRE6OcqAfNn++obnUFgyGy0+ihsO0CMmcfUxkoUMWKKGTxNI9u/iCZNM24xwjIxLJeQgHCfy/wloSF5F8LB0IrP6WtQlg0JWyxigXtrXinV+3mCKKBOlvYK/sUu06ikELWvlC0ed57yf6tOscTtW8c5nPkm9QZCyfdeuKbgE7mKBIFNeVO/sGYEagEgFke//qZJhZNCl6trXTWi9orx73KwqbhboBC15/lHZZ1ZYzxkxWCubAmch5jMnzBH/Rr+aKBlY906OnNxuZaYryay/QU1Ra/3t1ruCGWSPxWvMouEhqw3wUXIEkPiXXH9uys3CRZxNJhAM1beULjT6CgBJtU94libTc3vUc+CWvPWDOl9OOViNudmBb/InHlCATZe6AyKrQmi4wrUA40qOoHw4wBECQewMdRX3bhvWyt2iKXVqmkh/Tlzv+w8Vhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(136003)(366004)(53546011)(6486002)(86362001)(6666004)(6506007)(478600001)(41300700001)(83380400001)(6512007)(186003)(38100700002)(31696002)(2616005)(66476007)(5660300002)(66556008)(66946007)(8676002)(8936002)(2906002)(31686004)(36756003)(316002)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNNVjdTV09xQll5eHhITmN0QTN0RVZGOTJNbGc0K1BkelpoaEQxZGwrVDhq?=
 =?utf-8?B?dFRCUlVUSjFzSnB1QmVDQ2lwVmJzZ1RFWUg1Z25YZGprdTQ0Y09hamdlY3Bx?=
 =?utf-8?B?WTBtVGdHRys5MXl2b09VQXJHYXRHRXY1aTBFWTN6Y3d5eUF2d0hKdktoSDVw?=
 =?utf-8?B?TmlYNE1KeDd6VVhuNXRtWC9ESHI4M1dSeXFoTktjS0ZvZkU4eldUOEZFSW5W?=
 =?utf-8?B?ME9VMFByNWR6dnVlS3g1VWN0WWVqd0pOc2VWbnk3dnRnUzZNbGFtbnRGNUhW?=
 =?utf-8?B?b0VtL25CNlhDSlpueklNYzNhME1MSTZyUERDU01SWnA4eEtnR20vWmZEallD?=
 =?utf-8?B?Q3pjbUhYSS9aVjcrZFNBS0FMRVhQeElDNFB1bGtrUTBUa0cyNUhweFp5eWZy?=
 =?utf-8?B?WXNiS0hlOHlTdkp6dlNCNFpaK0FkSXdMSWpTaVJib2xraitVOXlEUkhTeTlL?=
 =?utf-8?B?TkkzemwzZ0kwREg2NkE5QXpYeGJvTldvTFBublFNSEZScmdRekJXdXFOcGlF?=
 =?utf-8?B?N0c5RjNhRE51SXp1bDV2YmdkM01XK1c4M3R5amk4YWJ4L1A2NkZESHhZcjlr?=
 =?utf-8?B?eTJHUnlPdTRkZkNxbWxVTEgrNy9uZDROczlYVjN5bFIzMnI1WE1FNnBOWnJQ?=
 =?utf-8?B?c2crQ1I0aW5PN0NvTEZ6NmNFUmVGL0dHZzJHUW5kejY5WEZURTlOdHVtdW53?=
 =?utf-8?B?dVRCRUo3Mm10TmpaQW5KSHJMWUwvK0Jwa3pFdklYem5ZOGErcC90VXR3OEpn?=
 =?utf-8?B?eTlubkk4QjBZRnNBM3VIb2pLMGxXL0pMaXZjRW1Kelp6bVNVcThkcFlCK3Zp?=
 =?utf-8?B?ZnFUYjFvS0Rvdm1YdEh6MVJhV3V2RlRIQTNST1RtUlBxUU51ZmFrVFhjRDBk?=
 =?utf-8?B?VitiZm5OZHU4TDBsM3FIdHlrV0tMclRkcWF1TnVoU0szRnc2N3I0Q0ZjN21q?=
 =?utf-8?B?WDlQWXU5RDJLMW5PeFJzL3JDMzh0NEFneXg5QkYrRlNCd2h0NGtZNldVNFp3?=
 =?utf-8?B?OVVsbG50Yzc2YWsybFNMZU1VWEtmNkZGM1o0Wms0eDFYaExjbDBUTFBPL1NI?=
 =?utf-8?B?R1RCSDlBTTdBMFpjZ2VYbkk0RGVLTm5SWU1RU1hFNUFOOXBmNllydE5haHMy?=
 =?utf-8?B?ZlZKVzFESVdDd1hqZFJRWE1kaWdidGoxUUxOalc3VkFsYTFpOG5HMlBUbWlD?=
 =?utf-8?B?WUs0VmZkWk45U3MxK0RzcE5YZERvcUNHRDlFeUpFTyswM3Y5UVBrZGpYa2Rx?=
 =?utf-8?B?VkNReS9rTnJqNmx1eTYySEZ4azZEOTRLRW1ZN2tkS3FXWlJEWUljSSttdDdN?=
 =?utf-8?B?bGdvU1JpM3kxaEUvcnZubVgxSDdtNXRpU3RHOWJjZE11ejhFV1NLSFNuMjd3?=
 =?utf-8?B?OUl4SUI2K2UvTGk5R3FWcmxSTE1XWW92L2dUTUpKNU5lUlVOYU5HQVNBOXJu?=
 =?utf-8?B?WXZXQS82a3hHZ1B0aU5Wa3Y3SXgxOWJXYkU4QloxMEtYaVllak0xaUxSZG1C?=
 =?utf-8?B?amdsNnRPV08rVHRjYjk4V3REcG9tMkNYRld3NWdkc2x5dGVtREdyYzlQU1Ir?=
 =?utf-8?B?NG5zemsxWHp5UkVGK2Q3cEVPREZQUGVVWTZMdHQ3TGpFQlZXNUF5anRyMUJ2?=
 =?utf-8?B?UlpjUm1DL1ljZUFMZjV4K0JieEVlU1ZSMjlTeWNtbXJzYkVkZFRnTDBKdG9V?=
 =?utf-8?B?VVBIc0VCWEFvZjNnUWIwdTdSd1dTbkw5eVpZcnJqbjQ1OGRuQndSeTQyUnJU?=
 =?utf-8?B?cUJMd3l5L3BmclpYb1NkNUVxb3VGT3ZpdklHSk4rK2p2Wm1FMmZEa2pVQ3ZK?=
 =?utf-8?B?SWhOTTNhNnhIMm42YlZLbVdyVVM0THdvTUpqOEVWMjJiT3lPREtwcFlZR1Jq?=
 =?utf-8?B?RVBXTzFXeUZUVGUvN0EvQS8xSTQvRGlmUkZvREZzZGxsVjd6TkZmM2Q2WDQy?=
 =?utf-8?B?MmdmV3pLcjkrYkNXQ01pdlJpbzh6UDAzbDBQYnAyY0JDMXJKYzFnemlyaTJ5?=
 =?utf-8?B?aVJSajRmckxhVFl3YWMyQXZ2YnEzUlVSZlFwcWFQaTJLODhuKzZjWEZDYk5G?=
 =?utf-8?B?S0x4Q2tVdlByY2p5eXJob1YyZDFFUnRKUFlSY0tTZE9MelB4NjZkYnRFaVdE?=
 =?utf-8?B?bGE4ZCtpOFM2ak5HeW1meHdjNkFtRm9GNi8zb3M1TUk0eENKNlJXS2JidjNz?=
 =?utf-8?Q?O5SqrzWS945DqEdwwrpz5NY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cf67c5-cb6d-4b3d-6b88-08da8a96918b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 14:47:32.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ykeOpJac1zCHAjEK9bfP0xwyvi6KIJbpUZeXJQZnxM/S06gjdCO1g6WhmoGAs+Rjt1rgUvVY47+snHPyL5i0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 15:56, jflf_kernel@gmx.com wrote:

Hi,

> I agree that USB_QUIRK_RESET_RESUME seems fishy with a hub. It's pretty much the last quirk I tried, and the only one that worked. I can't say I understand what it does exactly.

Two things

1) force a reset after a resume and call reset_resume() instead of resume()
2) block autosuspend if remote wakeup is required

I suspect you are actually using the second effect. Have you
tested with "usbcore.autosuspend=-1" on the kernel command line.

 The hubs themselves don't seem to reset (or at least not fully), as
there is no re-enumeration of existing children.

Probably because they do not suspend at all. Generally hubs do need
remote wakeup lest they forget the port whose activity woke the system.

> I have not experienced a single problem or side effect since using those quirks. I use a mix of USB 2.0 and 3.0 devices, some bus- and some self-powered, some permanently connected (including ethernet and audio in the hub itself) and some not.

The interesting test would be to see whether a keyboard, ethernet
or mouse can wake your system from suspend. Have you tested WOL?

	Regards
		Oliver

