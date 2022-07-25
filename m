Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223BE57FC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGYJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGYJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:17:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1448B1D9;
        Mon, 25 Jul 2022 02:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gklpGtSiNokhJSgoiSiULvP2frJpdtg3mqAh0W1+cgxTNRM6mO1mBus0CzWyRyEmu/3rdkuRML4d2g/65PISZaYwp+eIjC5Z3xFMuUWPC4GN1cL+jwVsaDUceW362JXyCFXzbNMCN4jWnrkhzT5+BtJhpSLqyY0m3r6c7mimSQTRsJc4ofPoBjbYEn2QiUNuVJgfXH6qZDhJWEtY0j6KQJTMG4nJLcM99TLS/E7kmGBMTmh3g+PZhr6kwGY3dEMNakUvSnyvgQDvPr5955HF+PzLvRs+/PZq3bXsNHHAvoBHWzJ+fr9WGmupnY4XDo3jGbd6RvCu9nHTzlsiKCpRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2N4OKoIgTJxlB95uJ6sCWRmkz55yw21u9y6n1AIV7k=;
 b=KpueAry55qxITfca1YYZks75mCtmaQYMIJY8/vfQcdBIDZZPVPDTC5IqVGPR4v1yGg77yUWn8N8EZ31mcrfc4k2DkKI28jqFNdW0v0tj+uTXM9AWBovdEqR/FgBI0sMa7Jw9NfwRX7i6VmrGOORDGAH+Rn8YA2tOm1JvFNPGqfgxMFvV8Q70d1KjFqyQJfANmq+GK15TQsGRwZBkkTCXW2rmVi59AZM+rkzRI3/kLAj3uGwGJB/9c+Hm9M/m0FWokZG4r/Cdbchkqn4VwCykgCSwkbI/Ykt5qUAkz7+ebr0EsRIbbeP/vYIQ7BT6iFfffKU7juoFhP5uA6ezdaH22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2N4OKoIgTJxlB95uJ6sCWRmkz55yw21u9y6n1AIV7k=;
 b=ILn1a3+ElS3/9Kk2qJm01tef5OhaZhThIB/atCDTvtV3t2X0b3EfW+FC59LzFDgYorLjH5J17Q2cGC1zbxiwW7NfWz2OhbexjPzZQHz+Iw7wlotLJxgbYxvxYeJf/sPFuam7mnXx88GzmVkJQkYXoQUPlxH9y2XDyZLYR3NIc9K+I80pV5G/Kh+yCkdsHdTmLzNfDiDEEbvAMLecjJtbO7DMe3CRWsZ0JORJUbbS4+4Z/jQ3iwJ3GnV4FrTEkDb0oPUyRfJTYV6MzyDL1i0ppWi0luXbY5WToP6LmhULh7UWkXQj5vCaHFZ38UNuf3ooYjpBAnqlHyt1ScwPuKV9eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 09:17:33 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 09:17:33 +0000
Message-ID: <769f27bb-4a90-eae7-62a6-ee11102e8367@suse.com>
Date:   Mon, 25 Jul 2022 11:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/7] USB: cdc: add serial-state defines
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725075841.1187-1-johan@kernel.org>
 <20220725075841.1187-3-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220725075841.1187-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c888d49-625a-4581-33ee-08da6e1e81d9
X-MS-TrafficTypeDiagnostic: AS1PR04MB9382:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRDR4fgrihRV3Q9sd9V2fhrfFqQL6tnc0wF1mzV4cT+lZVyxkZhS9Kr6UsezfbmXUjHsERIKGCtV61jliMRt8y/8ULRRcD/JwC3VagUIJHplr/41sS7jw3kzA3xyFUyXrCPJkGW8rTOesDz6lcOe9mqhnfzNUhBBjd1JN9B1ar8YzmRM4FuWHaCPmDp7aZZvILrpAJvcCh0uLr7I5Y/etpA20+CPwLyGLRGJZ3SfMjKEMkWTApAhwAdbUmC7b/R63hprstq1F3IGWEGp8eAMkkK7u72yLpNtr/3LF4xRQSAIbbU5rIoVteA04sBHeV4XYI3V1rKYMrNdSeIxSmp4J3NenffYePHAUwSrMrX6sT0EoOPdsAKJ+HuUUUmgn97zcBVlEkrdfl6t/cQ1Ckcn9bK0qkgOvGWgP/kXeYJMrqQNhBXlQdgJrIoEWaSKB3g5QpmUDYJoc8ziXy3+IBRGp9mWC1zVlKlkF3oJyXtIeQyC309EjgtdCOp3sL5yEdG8pl3n3cuY05FFT2Pfx03lanBsVaLmJ6Z8wEm1d8j6lORZuc0W/iRZ119gHBpsVh+BASYZ2qkgkNoHCuMIuI6HpOnaSdYvDC2GPnW6Z/MhlGCUbk/I9K1mXxFsmnXXnMSAoR7y/1o0+WhC7q3z++RwZfm6P9se+oX1zl+ieE7Aq/xpbYlkOqN6XoFbs5juesp4fJKD1gCEb9VZMU3c251YxUtfo9bsaBXqm7ba3PxCy/di3tibIOuBZpu/eVMPoRiXIRLEp83Z/o9B8bCJyWCPwfclMfrVNdIFF2186k8Vv/9HXewXnyrf4ebxziUNLPhZDd+g34j4rrEnaRaTQtUZCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(66556008)(4326008)(66946007)(66476007)(8676002)(110136005)(6486002)(38100700002)(478600001)(6512007)(53546011)(316002)(31696002)(86362001)(41300700001)(2906002)(6666004)(6506007)(8936002)(36756003)(186003)(31686004)(2616005)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNIZXJmb25HU3FaVCtjT1pMbTZNY2N3S1NHaDhXM3I2SCtYR1orZndRTXRN?=
 =?utf-8?B?VDBYUGVYWEdPVmVHRVUzVXptdVIyTmtIblR2QnhtN2FYcEFUSzA0VkoxUDBV?=
 =?utf-8?B?S0RHbHgwQTF4dm45b0VrdUJ3VWY2SGNPcm1TRWZxNDBmZnB5WFIwWUNDdGpG?=
 =?utf-8?B?TVV3QTdzaFdRSTg3aVRyZTlMcEI0WUtnZ2dZQkwyeTNzWWljMHhUbXFoRWc4?=
 =?utf-8?B?Um55THhYZzZCc2FjS21NdTlMVVIxRmVsUkpEVkZyait2b2VrYXBSSTVuM1di?=
 =?utf-8?B?bGRqaXhxRFdhZWxJWkpVNC9HNDhxUThhRGhycThxcm9vMVlGalVlOGhFMy9i?=
 =?utf-8?B?cDA3eUY3ai8vZzVCR2hRZWQvODBjTVhSMmZ3QzN0amtrbnREUTQvNloyd1Ba?=
 =?utf-8?B?N0lzejkyRi9mNmlOMUFnSU1ZUlV3Um5kd0hMSXExdjNJT2pNamV1b2lva29J?=
 =?utf-8?B?SC9wWVVvZFpVem5wbWE3d2hQOUxTNTlCOUxxTnk4TWY4SDhlTndmN1FHSEN6?=
 =?utf-8?B?S3g3Uk1xQ2lrUm54a2F6WURyNnJKQ2hDRnhqK2hFS2dTU2RXYWhabHUvNVlF?=
 =?utf-8?B?MitIamkrMjVwQVN3cjRUWVIxTWUzUCtUamMwTXJzeWxUNFJJVGROWXZkZFo1?=
 =?utf-8?B?MFVlZFZ5UmxKcTFFRWI1cUoyRExTVlBZQUJYQmNsZW81djR2NjNDalZZRUk1?=
 =?utf-8?B?NjYyeVpIcjF1R0RJWnpZWGhabXZUcGdSTVFqWkdlK2FBZVBnNk91NUdwZm83?=
 =?utf-8?B?cE4wd0UwVkUxVWxIc2E3OTk0MXRqenNweDlxa1lhTE0rZ0xuT3Z3WlVXY0FU?=
 =?utf-8?B?NU5wSHloRUpneW04WEhKSVdUTDluYWZqUUVQaXFsZURNR1dhVDBRUjdSTzda?=
 =?utf-8?B?NldmT25leEJwcVNxcWZ3aVNabHpmdUR3UzdXRktBV3pZQzliSU5BRGh3Q212?=
 =?utf-8?B?akJ5dWhuTVVuR1VQSU1pNjU2ODJNNE5QeTRWQ2VzWDB2RjEyUGRlK1Y3WEVk?=
 =?utf-8?B?MzRzN2d2QzhSWWg3RDd6Q2hUbUJYVk4zdjFNN29VL0tSaThJTzRIa3grNVJK?=
 =?utf-8?B?K0xoWEpZeWZKSmJLUEdRRFJZMk5jeU5peEJXYTlleFBzWjVCK2NGakZ6R2Zo?=
 =?utf-8?B?T3lycGtVYVlqSlRLMGJsbWwvQ0tsaWQyNHp0cGVHNmNleG9ERjYvdlVTUnF4?=
 =?utf-8?B?YnBRVlVwOXFzZ0NMSXdIeGFXcTRCN3NTczdxdDNLVll1NktOZVVTL3lsdmVz?=
 =?utf-8?B?RlMrMXVmQ0JDU29lT082NkVPMVZBZU01VmFQejZwUWZoOFNXZlpDaFBXYVRI?=
 =?utf-8?B?Vkd5SGFNQUVQSTRQSHQybmcyRXNZeGlXVCtXaGd0SnhJSngyUHBLdFNxV3Nm?=
 =?utf-8?B?MEIwdVFnT3FBdHlYZ1l5aXJBMUI2ZlFWTUhsbEk0UmVMeE1sK3plSHZZd216?=
 =?utf-8?B?b2JLVWJ2OEFuNkdyMTBSQ2FpalFkNVVvNy9rWDVySXdlWktmcWJLT2tVUnYx?=
 =?utf-8?B?VitKcXl1OWJjSFJNTGordWRCQjdINkJSeGd5Y1h6bHBRS256WC9YaFNzeUtp?=
 =?utf-8?B?MzNDSWtDUXJ3UzJ0dG9RVEVDNm9QYkR4cTRoVG5mbXNwcldST0x3a1E5VXpZ?=
 =?utf-8?B?eThqU2loaUxRVVEvZUE2M1hWNlZQZ3NGeHJ3SnRGNjgwUUpyN1VBNDVoR2xO?=
 =?utf-8?B?c014bUhJMzdDdDNqem5zT2RmR2lSN2lZUWhsd085MHEzM1dPMWdwMEw2WHZ1?=
 =?utf-8?B?RVJQN1JEaWZMc1ZNdkNHRjVnNGY4WkdxQTIwN2lxYkNQckxXalB2R2x4ODJ6?=
 =?utf-8?B?REJxNVJ5aENOVE5ucjVQR3d0cldUMVlpNklRVEtxc1pPVUhMd2F6aXNJNnZL?=
 =?utf-8?B?b1ZPQkc3SktrKzhGMUZUNzFaR1lhbVFlU016Z2VkSnE2ZUVJYjlwNytXY1pN?=
 =?utf-8?B?WDduUWpQWHBab09zSHRMTkxKNlVSNlFxMVJ6MUVFbXRJSzV6Rmh0cTl2aGQr?=
 =?utf-8?B?bmIyN1VmdnJVVXBHVnhOQUQ5VXp3cUs1aFZoVTVFekdTS3h1U0xmSUJRNHJo?=
 =?utf-8?B?R1ErNWI5UzdOajRiME5vR2lBYi84cDJMV3J2OTdFQS9ndWQ4bTBZdDhzSEFI?=
 =?utf-8?B?MXlxZmVwMkkwYTJTbTZLeG1yVE1lOG96WitYeHg0a0tDUnhYdlh1ZEExYnJY?=
 =?utf-8?Q?TBTJkO4R6wMnhba7FSEZqGl5fhqlkUD/Ka14D2Dc621k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c888d49-625a-4581-33ee-08da6e1e81d9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:17:33.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoniEr0vM51WwNNGeFaAUTTDCJf7tKkFgxp05ujjqoKHBSb2A5ceZwQow9mWS6i/llxy9K8QcWU+h2DLNkFYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.07.22 09:58, Johan Hovold wrote:
> Add defines for the serial-state bitmap values from section 6.3.5
> SerialState of the CDC specification version 1.1.
> 
> Note that the bTxCarrier and bRxCarrier bits have been named after their
> RS-232 signal equivalents DSR and DCD.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
