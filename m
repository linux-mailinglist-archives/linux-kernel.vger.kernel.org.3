Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECBE483589
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiACR03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:26:29 -0500
Received: from mail-am6eur05on2126.outbound.protection.outlook.com ([40.107.22.126]:46624
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232003AbiACR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:26:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVKAmNwn6Atx1hToe+wms61yCfr9FPwCn1k3rqjGyRPYy1qO1vVrfAVIkL28IaaSBy6wlOLKoCzJ0qBISjIRzNG9hOr88IQjF4ndY38AX3+g6Vk5bsmaRYaa8oR2O2w2JHZNJDmtczovXGlyLgTQgQjMS02lLFRSdOJuqgSACRVhg9l14OAB9KsS6/lA80Juz5gkiN5T9ZE/70M/VtW6YZuQubp9vslN/Gm/uJL7ri/s43gRDZTwxJ5St3I/WrUs2JHAjUbbKPV+5UZPsDczDL81qGK7lZhTN1dhcg8FVUogukRUHadS0cc5RkGIXSmgpfKEMvkhZ3Nsdn3lJ2ZJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcG5fa9s8j5ASwjaNpy370gto1eUUHa/QJBmrsZrv6Q=;
 b=H8UmI0XYg/Zhvyu5xsWKd3FR2tKn7OOoMU7BYSyE0uJ391LII5Lgr8iCt2pXeXBuz40blWJkxPHuQQ/a7zEzmQSo1Epc1PLMwV6NzZqCDzQtB7sw0Nh3liWcBM+fHU9nIso1YMIA7XRovqYnSiTcv/ckx7yFBRqtixRmSMZ4BMxiwezc44pV5uHooMVaOF4mozLNyFNikbBvZ8a9/Iw/g5PvhnejuThZmAvEuuXWcNytp97cL8kcL9WenylWtv73hco1eCAiQXDT0dezteL8C+8Ht+c51hbO5ESuOWSnsCbPfGNJXRbrfw0oB26deVrFoBbSg0RsL+ZSMijgwGPMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcG5fa9s8j5ASwjaNpy370gto1eUUHa/QJBmrsZrv6Q=;
 b=DWGXx3Z5GfB1zd2DeIPwShSNhJ2YfyFheapcdBkdjKePOi1fzG8TsanJB6AGSn4Azr69XrAKsQ98zSPDCDV8LsxknFvULy2SfmkaTYZAXqe800I64BelYQIDk+aK9qct8QkAdKmdnDwo4QLXIOQP2O+klReM0UiBnDpOEHyMSoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2613.eurprd02.prod.outlook.com (2603:10a6:4:1b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 17:26:24 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 17:26:24 +0000
Message-ID: <08a48424-a8e6-f08a-63d3-b00aa5cd33f2@axentia.se>
Date:   Mon, 3 Jan 2022 18:26:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/6] mux: add missing mux_state_get
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
 <YdLvGge5SbuhAi3N@kroah.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YdLvGge5SbuhAi3N@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8b9656-7adf-4114-c976-08d9cede2a75
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2613:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2613DA778C60E3E6BC8C6696BC499@DB6PR0202MB2613.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGUpMbffAP0z3nyYs+CfVjBSnsSc0BQMDRzXIfXwwX2LwBMIcpng/0LnY/Nrwub8OGitaP41o9dy4tIDH/Q6sdngvG26RXxZgdAyPbVzVyF61m8+pOhW2npHJstJRe0IqEDL59SKy5lXGk4j3AxCxdRvOHd8JXMoZNhX6RseXe7wDre/mdoZXgpAoVLVoVJhGHf/JaWy1icUJ3ccROljBuwUsLHd/xlDiIRb7dJysVtzbz4fAyt2DqsYjQ7NBByvr6GLZ5dsX+Rvn8tcQIAFIOs13K3TEj5aiMFH86zliTUtSf76u+Oz7zR3CvEdw4fRlN45EBuSoptf7FWtAFmXZRQAGnTEbC6i9u5VXSl5rcVJQ+kBK6TWe8pTuuwfftrdf56Y0UNwlMTyje6JOrrBuKDTfLigE52scPMlY4oCh6akUqkoOm4T0pHqhWnoP7HyB+tMppRYlUpm+lLSSvq5bcBKGjrjQYGnUzWR6bdgmMTVysmVU7weFJv1sRaxhpJ/jNtRU9C2AXSKibQXoP7DkUu3NcFGgLB/mBRgiVRzwP8mGFuXJkQ9GaMtyzok+jwVjYIheV+QUXyqkDh2+ps+B61qI/eOV1j4TWDF2OHpszJOw2/6m+dyvToa7HdySB9Pkz9Q+SZRxIPNOMxOvxPt2q3/gYuD1rxqLmvTdfG6EJkkV2DQBbpad2Yrqmv036JOMQtD+Qk+74F+M8Jw5L93pAEQmzhsKj0EqXGjKUHCv/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(31696002)(186003)(31686004)(508600001)(316002)(66476007)(26005)(66946007)(8676002)(36756003)(54906003)(6512007)(66556008)(5660300002)(4326008)(6916009)(2906002)(6666004)(38100700002)(86362001)(8936002)(6506007)(2616005)(53546011)(83380400001)(36916002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak43Y1ZYcnE5UjhFSk9zM2RMN0ZBaXNiR1Q2ZGZTRVVKbFlCRloycG40c0RE?=
 =?utf-8?B?c0tsdjNwaWVSZzZjYTVRVkdaK2ZDL3NuZTAySmVDRVp3NlgxdHlmNFFweXpO?=
 =?utf-8?B?TVV6cFZIVGQ1Qm9yekVOUHp6V2lzN0ZvV1JQUG9keFdkeTF5V3VhSFVYU2Rs?=
 =?utf-8?B?UmVhM0tuYzc5WDhXVjVtNDlLY1lWd1hLb25VbUdsUkdmWTM3QStVSWhwUUt6?=
 =?utf-8?B?NEZxY3gzK2FNRW5LejFWT1RITW5nZXZ3VlFVNjRtL2crNUhENXBzSWN6Tldq?=
 =?utf-8?B?VXVMVkxKSHdkc056SVpNK21QZzFERVRSL2hHdnc4b0FDbjFoV2Q2K1BOKzdu?=
 =?utf-8?B?OFd2Y2Exc1dDZlR6QkRyYXAzams3bDNvMmN1RXVUYW1GcC9aektsd3pjdlFv?=
 =?utf-8?B?WUZpamRVRno5NjUxYW1sVUU4Y0JkV0xZZDZCaEVERExaSUZiY1NFYzh0cUdl?=
 =?utf-8?B?WTNLVlFMOFVHWDJxckNWaCtnRTZMakI0LzYyeUlMQi8wTEt4VVgrM2pSZXRV?=
 =?utf-8?B?MlVUWTJaVFFMTGNLZk5rOU1sN1FzUWVtY0FKS3NBemM4dTN6VmVSZEpWSHpP?=
 =?utf-8?B?UnZEc1FVV0U5NDFaK0JLaUcrME5zbkVLczM0SmtmSGtRTExpWENLZUp2cVN5?=
 =?utf-8?B?enRVVXFsY3pjSVhyQVFSNGtTWDFnTVhhNHEwWHVnaDBGSU91ZDdNOHZYUHJk?=
 =?utf-8?B?RTZvNVRvVDNjTHI2TjNKWEJ6djk4VUtvWXRFdFI2dUp3RjdIMjk5WGk5QVJk?=
 =?utf-8?B?eVk0T2VWQ0ZnMHEwWEJYMTV2emd4WmI0Nk8zWmhEay80S3lVUFR4WnptYzVQ?=
 =?utf-8?B?d2V5SEZkOWdYVWUxOWNPcDlUTkNMODl0QnppN2ZQTXFjQTJFN0tsSThuVHBL?=
 =?utf-8?B?NlNGRkRhZ3YyRFhkdWk3cnNRWnpYL0NNUStRWDFDeWhsU0R4T3hZbklYOHp1?=
 =?utf-8?B?SW83anJWSVlCa1Uvb3FTSytKR01ReVZjNDI0SDQwOGpzcTRUeDFFeVFVamNo?=
 =?utf-8?B?eGFteWlzUmY0K24yejdKZnhQc0UzVlpWUjRFdktLOUpqUVhNSkJ4WDBMclZI?=
 =?utf-8?B?TitFY1JWRFNvWWdiRWltU3l2dEdTdFJ5N2lzN3FQV3J6cWRVZFFsMWtZYjdJ?=
 =?utf-8?B?aEFVV2x4bHhvaGF6VnZXWUFPU0VmWkdXNk1VenRXT1I5ZmM2T2pPc3Q5c3A4?=
 =?utf-8?B?Ty9PWEZyTFFIdDh6Rk01RTE3a0NnS0tBSGk4VWxkSytUVFAzdUU3VjNUcWRN?=
 =?utf-8?B?d0VZNmJZcHlaWDVUTjM2TnlwVWhNWmpZRDF2YWx6ajQxK2VKenNsU0tLY3N4?=
 =?utf-8?B?ck04eW8yUDk4RlFBRGlLMjNuU0g2YkNUN2YxbzVJYS9LdnRHeVhncURnWXov?=
 =?utf-8?B?YXNzdURyNElUbldMVFhBeG5sckkrRDRhSlhXVUl4M050UFZWcGhMWHkxR3Uw?=
 =?utf-8?B?N3hwM25meDdIdEUwTGo3eGUyeC9FQ0xMRXJIVjRnRmNnZDU0MHJ3eWNrVWtz?=
 =?utf-8?B?MC8wUG41K0k1bmpGZGc1d1V4dWs5TjNLaFBtaGpSTEtPMi9LOWtLdk5ldFVT?=
 =?utf-8?B?SGcvamlOUHdsN3RyTXFhM25pRFRSV0JmWHVkd1BycVlKbVg5WHYyZ3JlbXJ5?=
 =?utf-8?B?VVBaZUxFcExrOWM0cW81SjNWcXdhZEJPdFFHVG9HR3J2YmRKbkt4Tit2U1dn?=
 =?utf-8?B?NmRuTzlZRERLOUpVSGs2WEpwR1ZXbnNxT3JzaGFRM2dRQVdKR1A3YmYwZU5L?=
 =?utf-8?B?QnBHU0czUFd3cjF6ODhSSVpicjBjY3drUTRnMForakhkSzNpZnJkRXZvektK?=
 =?utf-8?B?eFFacWllT3R3Mlh5Z09hdVhqZVRnTWFLUU0wZm92REZ6clRVSGFXbGdYaXRH?=
 =?utf-8?B?RTI1TDhSRytPK2pXRGxFaFBpVDZwdXpra3BBbHZFSVdIazNzSUx2NlNlTy9s?=
 =?utf-8?B?VkhMeldnMjlPR3BBQ3pOVmVyZjlRTnlUcjNDeXZWRFdyaEZhdXM5ZWZCekZX?=
 =?utf-8?B?TnNBR2lNbWhNTExGSGR4SmFidVRndVd1VnJmSW95WmtjNXdWSW1MeUZuRklC?=
 =?utf-8?B?WGs4WU85cFB3K05VcjlVeHdBdDJYMW5LOWsvaTlqSjVxUDFkeEIwdlJhdjJ4?=
 =?utf-8?Q?+Xqw=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8b9656-7adf-4114-c976-08d9cede2a75
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 17:26:24.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMGZumK1x4UAk+YT14LC9NW0cyEngo1ie9M9GZzV2jBWGledwFsQ9HFtRIy38PZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-03 13:42, Greg Kroah-Hartman wrote:
> On Sun, Jan 02, 2022 at 11:38:36PM +0100, Peter Rosin wrote:
>> From: Peter Rosin <peda@axentia.se>
>>
>> And implement devm_mux_state_get in terms of the new function.
>>
>> Tested-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/mux/core.c           | 41 ++++++++++++++++++++++++++----------
>>  include/linux/mux/consumer.h |  1 +
>>  2 files changed, 31 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index 7d38e7c0c02e..90073ce01539 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -673,6 +673,33 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>>  
>> +/**
>> + * mux_state_get() - Get the mux-state for a device.
>> + * @dev: The device that needs a mux-state.
>> + * @mux_name: The name identifying the mux-state.
>> + *
>> + * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
>> + */
>> +struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
>> +{
>> +	struct mux_state *mstate;
>> +
>> +	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
>> +	if (!mstate)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mstate->mux = mux_get(dev, mux_name, &mstate->state);
> 
> will this build?  I haven't applied it but mux_get() in my tree right
> now is defined as:
> 	static inline void mux_get(struct gsm_mux *gsm)

Yes it builds. As mentioned in the cover letter, the patches have been
in -next for a couple of weeks. The static definition you are pointing
at is from n_gsm.c (which does not seem to be #included by any other
file). This definition of mux_get is again static and in a .c file
(which is not #included by anything). Surely not a conflict?

> 
>> +	if (IS_ERR(mstate->mux)) {
>> +		int err = PTR_ERR(mstate->mux);
>> +
>> +		kfree(mstate);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	return mstate;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_get);
> 
> No need to export it or make it global if no one is using it, right?

This is support code, and I think it should be up to the consumers
to decide if managed interfaced should be used or not, and would
rather not push anyone to managed interfaces if that does not work
or does not fit for some reason.

> Also, who frees this new memory you just allocated?

mux_state_put

> 
>> +
>>  /**
>>   * mux_state_put() - Put away the mux-state for good.
>>   * @mstate: The mux-state to put away.
>> @@ -705,25 +732,17 @@ struct mux_state *devm_mux_state_get(struct device *dev,
>>  				     const char *mux_name)
>>  {
>>  	struct mux_state **ptr, *mstate;
>> -	struct mux_control *mux_ctrl;
>> -	int state;
>> -
>> -	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
>> -	if (!mstate)
>> -		return ERR_PTR(-ENOMEM);
> 
> Before this state memory was here, assigned to the device, so it was
> freed when the device was unbound.  I'm missing where this now
> happens...

Again, mux_state_put (via devm_mux_state_release).

Cheers,
Peter
