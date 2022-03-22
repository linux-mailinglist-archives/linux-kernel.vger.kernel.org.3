Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EDF4E45BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiCVSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiCVSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:11:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5A65D13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQbPDdzt6i0u3gKzXFupzfEn5ApSiOT47XB7LMJTDet4a0DT22bVk3gpf7i4hUDiPU3PXFZN/3UG12qmSRUB1qiLUjGUMs+Qrx29cogdEsH7oTodGyR+tA8BxxiUCgbXh/Qr4zcbGXnt8tXTnZv0p7WtYH1VwE3cffOchf9mU6w4EolDQi5PXeB2mMClpzjKMp4U1tTCo4B4HtuzYD39hDJqBWZRyYlPboz9B219q2luk9U2VmtW2Rdbimh7H8q+i7ilaCxb12HrJecFwoYL09oEK8Y71QVxU8JLeaVd8Ncj3F8W+qRMdGFkK6RAHBE6/2BPNY1gU0umU4FoUZys6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RafdXb3Cjzk3YPVu7AnF9oPO9DGXfL27pUXyKbrP7iU=;
 b=EZbTUiC/LRyQ9jCMcRDq+vs0QUwLLwKAx5uQnEtr5YXJyVH6OL5ZGWEXDkODojUvXymmHAjnz3raQKuG8zjpj37+BbChEz+8jmBfG0PFZea0tadH5v7c6x2L+M+NDaPVBrZQ6zjEwUBIv/qyvyRvPsOvqo8ThrdM3nSgcXRYkXct16btt3xdGTfllPHzSziCvdtpYSfyq1fQ77vl03GM0iDmVBRoWS6YFqWAU6/CN6Ged2qqbtnlSBelEhF8DjyggH1TD3R9piqoZm7KpAwN2ARGdWKRdVQLj3LvrsHQKGdXBGq+96T88hZVvklafsVBcs8pgR+QMyRyC9XE/p0inA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RafdXb3Cjzk3YPVu7AnF9oPO9DGXfL27pUXyKbrP7iU=;
 b=lIexKGP0XxjSbX0rOmSoN7m2PxzdMeDJ0cW9w+oUMWEIOoPzIgqT6dB8/50D3crFgyHKqA5HhbPC2ruVn65z4W4OZVjFUwupHzxQUt/6ekfvtqGkb3Ilr9LwDQLqs1pC9L+0GaswpLlFGGHMNkrCN2L1xDg3FNzv53nUCMQ1rHsh2STC35OGW3geyOre8qR9KmMO4XQN9BWxyfL7LOAJR656/iF5WmIo+iummGRImReS02MzAxo7YSRdV7UKh0kD+3kpnDsBZC0HF/PwVOGfl2lHGvXO/+9ZQFc4RUHFfhKDJX+MPkKmJ8HjbAt0xAFCF5yvW4k2f2JyORomT/yBxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM6PR12MB3451.namprd12.prod.outlook.com (2603:10b6:5:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Tue, 22 Mar
 2022 18:09:30 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 18:09:30 +0000
Message-ID: <c1f55917-c7b9-140e-29ed-937f1c2b656e@nvidia.com>
Date:   Tue, 22 Mar 2022 11:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 02/11] drivers: Add hardware timestamp engine (HTE)
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20220201222630.21246-1-dipenp@nvidia.com>
 <20220202035259.1875-1-hdanton@sina.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220202035259.1875-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c4f0c7-2208-4f7a-5794-08da0c2f1c07
X-MS-TrafficTypeDiagnostic: DM6PR12MB3451:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34516843A07190FDF9EADB36AE179@DM6PR12MB3451.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNVdgvaaWH0ou8QH6dueo8ZNkujgYQfr5wKBT5/eVIcs7Uq7D2gJi8P6erjGr9YAoGwN4zGTOWOtjUwjBrNpOehrqZ5OB/YcbWEX9w5W7UUmz5e6z1DwnmSEY4NI4yv9juq9FhK3zgXaKZUqQwXlG2SyY8DXygyvFmoYOEnZinVcUInmgIcPJaGphaTfCc+TqsihWCSRh8c9qrbFcPaMSoik5XiNWOzHTkkizYAfqawRbsmuFjm2TaDI/CDMgGht7bARhtsbcNCYMBOEdKN9uKZ4OHLkEUj6ltbmS8rIf8XuHac0fW0gJxd7ZOYbInwdJbkmxRP7buyK+GthHA41Ph0XJC4pyU3rf/+oKr2QMWz5Aujap8Fmx577KzmuwodbCtHeSIACPazWKuFQtEnT0bUVd8Wo0SRDKtHZ9jjESXPlGpIIJXaASviuc2xjUWrZfw+M5khdr8NMunayJZeviaBAAK5qm0qhImc7u8Jje8jphCn6MFzHsT/BnZGxrHQXRnQp6TY4nCp9OUBldD8NNDrpHkTS017l7wcIOmfQjid8iw88fTVYC7nZ2UVKdHb2BZTQ5nnYnW9VRy0hy/1xwQQJiFkh5lxRmUeOtZO2F+X8yh8bplxZrGZeMGs3wCF0s/tBHaPltXARv/5UmDUtbV0VGtXHcXGHD4oEQK07nuH0slZDVkwKjIUFqD5mV/zS6LFL3q96HNV8nVNPaXxfsLswPcf4PRIknWIzWWJuv4O8bTYSodPhBjboDqXQrhTd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(31696002)(6512007)(86362001)(53546011)(66556008)(66476007)(83380400001)(66946007)(8676002)(36756003)(4326008)(508600001)(31686004)(2616005)(8936002)(6506007)(186003)(6916009)(5660300002)(316002)(6486002)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxpRWRxZkZpRTdWZU9DV3RzZzN3dVpCeWxja09sU3lhVHI0QlNaMGwrWm54?=
 =?utf-8?B?LzlFcW9mWURPNWdoUjQ0N0pZOG5KSGVaOVB2V2VzRjgwZi8zRC96b3p0RVFO?=
 =?utf-8?B?SENncUl0TFZRempYY3hMRnpTZElTbUozbWhKMTFucldnMTgxYThxMldQZFFp?=
 =?utf-8?B?Ly9XYWtIVEgrYm4vQzZ5ajVNY3hqdDB5T21IblZrdGNnaW5nRmVsVldYZVN0?=
 =?utf-8?B?WXpVcmlTdHc5dXJnRDh2Um1XNnZMVms5V0UrUFQwOFVoaVprOWEwT3dUY2RE?=
 =?utf-8?B?cWhKUVA1bWQxc1BwaVduZVBkdVlJUUFmSmYxN2xZVTJ3QlN1N3lnem5Gc1JC?=
 =?utf-8?B?Q0x1cTB0cUxkN0ZFaUV5ZW01d2dPVEpzUkxpL2hCUEx2eEkyaDk4bWJNNDFU?=
 =?utf-8?B?eFZKalVST0NraDlkU3FKK3hCazRETm1EYWVQSjVMTzVvNCswdlJPRENOK0lQ?=
 =?utf-8?B?U1dXNmdVWXAwMVNmdVlXNXd1VS9RdlZnanRISndKZm9teXhFTituNWtFbDAx?=
 =?utf-8?B?TFpnRUZCNzdLRGdHTG9HUkNBMkx6WEozTCtuaE9CQW1pNW13SkdSblVRSUNy?=
 =?utf-8?B?TVRNTWs5ZFQ3UWRwc2NmL05oTmJHSjJIdUtxVWVhVURudGpOa1lxMHZQbXE5?=
 =?utf-8?B?VVppeUI4UktzYmVpOGJQaUE1S05wZUhtMmtNL1lxOCtIM3IrdTlXNFBvVktl?=
 =?utf-8?B?MHNSZEd6N09mSXpTSFB6MzU0ZDVXS3p5ZGlZVVoxamgyMTBHS3M1QzhiSVkv?=
 =?utf-8?B?V3Y0aEdWQlA3NVFwaytvWGxQQ3kwdEdOaWIxTDNJYml2aGlXN1B1cGJqblBB?=
 =?utf-8?B?MnFQd2hYY3ZFZk5GSG4zU1ZLWDEwRi9lWTVaK2dsNGtWRjgxZjFOVlFrL2Vm?=
 =?utf-8?B?TWpnL3FLUlVHbjRKR3R6OWpnNURSR2xTM05tQUI2YVJkU2VFUy9KMWN3VlQ0?=
 =?utf-8?B?WnRBZERndHZ0MVdpS0FEVDBndkF0RzFDNU5FYmIzM3p6Z2tEdTFpcFU3aGZ5?=
 =?utf-8?B?WGthNi9NTnBGczVTcjhzWXNUZjlsdDdMaEl1eFRKcXlVVVBNQ1RtZUZUdVhk?=
 =?utf-8?B?UGZqdWZ5aG1lLzJUNWRhTXZLNU1kUUs5OEtEVGJSeEpUUWpYbm5Zd1pSMG5v?=
 =?utf-8?B?N2VpdkhCaml0MXU1UDhqaGR1eUk1NkN5ZVJkWVdiZ3JKYThvTFlOWWtVQlVz?=
 =?utf-8?B?ck40QjJqTjgwQ2w0V0VQbXA5VmJDYUgvUXhwRG9RbC81TmJ6dGVVc3I0Z2d1?=
 =?utf-8?B?dzMveW93cXRPQVFiY3B1N1F5Tkd0c0tINUJYZU4wSk1hOUhtNU9tQnpiOTFy?=
 =?utf-8?B?N2ZWRzF4WTNQa3pyZnRKL0hzNi9takp1MENUZjFhQXBOSHU5Y3V4K0dNMmov?=
 =?utf-8?B?V2hoR1dJSE5SWUFhY2U0S0cvWjJQaU5xNE0xTWJPenlaSzlGdG1RUXNCeXlO?=
 =?utf-8?B?dEpuYU0yL2RWWDJJSDAzMnlnSEgxTUlOQUpkanQzZUNHSDdPOW5hMEJJbG9n?=
 =?utf-8?B?cXFUVTVEYk9OQnRNTXh0R2tRd1F5STRBSnlpUVptL0RPZnlOWGNmS0h1bHQr?=
 =?utf-8?B?WnRsc1NhTzdYQUFZOG5OdUdrNTBhSHkzNnY0eVN5akg5U0J5Q2h3MW4vbDRm?=
 =?utf-8?B?UC9WcUtHdDhnUGtXTXROOCtZNWE0S204UmJ4TkR6SmRLWUhYZkV6WTQ2dkRZ?=
 =?utf-8?B?eDBVTmlOOEtUUlVxa1lFZjFTRSsvTlVUeVZXSUtpeWxjSmxtQkZkWUp0U1I2?=
 =?utf-8?B?QWdSMjBOZnY4TWZqVi9OeFRpbW5Kbk1MR01BdTVqZGxyc3VXYkNRZnJIci96?=
 =?utf-8?B?cGVVUDhPRERDODZMbi8vbGtXMkVjSDlManozRkxOMnNEaWpua1g5Z0tNVnpw?=
 =?utf-8?B?ZENzclJMNG9kRVIvU1cyMzRHSmZaYW55Yk5hUzdBMmlLNGY3d29XMWJweWdM?=
 =?utf-8?Q?+eZGUUF0OkhUVi+c0jrl6zLki/j4hmQ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c4f0c7-2208-4f7a-5794-08da0c2f1c07
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:09:30.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpyAEatEqyN8uV7VURDmYl8wnmiYpSdeV8J645MUkssLemngVfQD+z09XQij2Tjejxb8GsxDdpWaPwjrhfgNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

The reason I used kernel thread as it will not be shared by others and can deliver payload at the earliest of course when scheduler decides to run it. The workqueue system_unbound_wq is shared by multiple subsystem and depends on the prior works scheduled in that queue. Is it ok if I retain thread approach?

On 2/1/22 7:52 PM, Hillf Danton wrote:
> On Tue, 1 Feb 2022 14:26:21 -0800 Dipen Patel wrote:
>> +/**
>> + * hte_release_ts() - Release and disable timestamp for the given desc.
>> + *
>> + * @desc: timestamp descriptor.
>> + *
>> + * Context: debugfs_remove_recursive() function call may use sleeping locks,
>> + *	    not suitable from atomic context.
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_release_ts(struct hte_ts_desc *desc)
>> +{
>> +	int ret = 0;
>> +	unsigned long flag;
>> +	struct hte_device *gdev;
>> +	struct hte_ts_info *ei;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ei = desc->hte_data;
>> +
>> +	if (!ei || !ei->gdev)
>> +		return -EINVAL;
>> +
>> +	gdev = ei->gdev;
>> +
>> +	mutex_lock(&ei->req_mlock);
>> +
>> +	if (!test_bit(HTE_TS_REGISTERED, &ei->flags)) {
>> +		dev_info(gdev->sdev, "id:%d is not registered",
>> +			 desc->attr.line_id);
>> +		ret = -EUSERS;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = gdev->chip->ops->release(gdev->chip, desc, ei->xlated_id);
>> +	if (ret) {
>> +		dev_err(gdev->sdev, "id: %d free failed\n",
>> +			desc->attr.line_id);
>> +		goto unlock;
>> +	}
>> +
>> +	kfree(ei->line_name);
>> +
>> +	debugfs_remove_recursive(ei->ts_dbg_root);
>> +
>> +	spin_lock_irqsave(&ei->slock, flag);
>> +
>> +	atomic_dec(&gdev->ts_req);
>> +	atomic_set(&ei->dropped_ts, 0);
>> +
>> +	ei->seq = 1;
>> +	desc->hte_data = NULL;
>> +
>> +	clear_bit(HTE_TS_REGISTERED, &ei->flags);
>> +
>> +	spin_unlock_irqrestore(&ei->slock, flag);
>> +
>> +	if (ei->tcb) {
>> +		kthread_stop(ei->thread);
>> +		put_task_struct(ei->thread);
> The code becomes simpler if the thread is replaced with a workqueue work
> alternatively.
>
> 		cancel_work_sync(&ei->cb_work);
>> +	}
>> +
>> +	ei->cb = NULL;
>> +	ei->tcb = NULL;
>> +	ei->thread = NULL;
>> +	ei->cl_data = NULL;
>> +
>> +	module_put(gdev->owner);
>> +unlock:
>> +	mutex_unlock(&ei->req_mlock);
>> +	dev_dbg(gdev->sdev, "release id: %d\n", desc->attr.line_id);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hte_release_ts);
> ...
>> +
>> +static int _hte_threadfn(void *data)
>> +{
>> +	struct hte_ts_info *ei = data;
>> +
>> +	while (!_hte_wait_for_ts_data(ei))
>> +		ei->tcb(ei->cl_data);
>> +
>> +	return 0;
>> +}
>> +
> static void hte_do_cb_work(struct work_struct *w)
> {
> 	struct hte_ts_info *ei = container_of(w, struct hte_ts_info, cb_work);
>
> 	ei->tcb(ei->cl_data);
> }
>
>> +static int _hte_setup_thread(struct hte_ts_info *ei, u32 id)
>> +{
>> +	struct task_struct *t;
>> +
>> +	t = kthread_create(_hte_threadfn, ei, "hte-%u", id);
>> +	if (IS_ERR(t))
>> +		return PTR_ERR(t);
>> +
>> +	ei->thread = get_task_struct(t);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ___hte_req_ts(struct hte_device *gdev, struct hte_ts_desc *desc,
>> +			 u32 xlated_id, hte_ts_cb_t cb,
>> +			 hte_ts_threaded_cb_t tcb, void *data)
>> +{
>> +	struct hte_ts_info *ei;
>> +	int ret;
>> +
>> +	if (!try_module_get(gdev->owner))
>> +		return -ENODEV;
>> +
>> +	ei = &gdev->ei[xlated_id];
>> +	ei->xlated_id = xlated_id;
>> +
>> +	/*
>> +	 * There is a chance that multiple consumers requesting same entity,
>> +	 * lock here.
>> +	 */
>> +	mutex_lock(&ei->req_mlock);
>> +
>> +	if (test_bit(HTE_TS_REGISTERED, &ei->flags)) {
>> +		dev_dbg(gdev->chip->dev, "id:%u is already registered",
>> +			xlated_id);
>> +		ret = -EUSERS;
>> +		goto unlock;
>> +	}
>> +
>> +	ei->cb = cb;
>> +	ei->tcb = tcb;
>> +	if (tcb) {
> 		INIT_WORK(&ei->cb_work, hte_do_cb_work);
>
>> +		ret = _hte_setup_thread(ei, xlated_id);
>> +		if (ret < 0) {
>> +			dev_err(gdev->chip->dev, "setting thread failed\n");
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	ret = gdev->chip->ops->request(gdev->chip, desc, xlated_id);
>> +	if (ret < 0) {
>> +		dev_err(gdev->chip->dev, "ts request failed\n");
>> +		goto unlock;
>> +	}
>> +
>> +	desc->hte_data = ei;
>> +	ei->cl_data = data;
>> +	ei->seq = 1;
>> +
>> +	atomic_inc(&gdev->ts_req);
>> +
>> +	ei->line_name = NULL;
>> +	if (!desc->attr.name) {
>> +		ei->line_name = kzalloc(HTE_TS_NAME_LEN, GFP_KERNEL);
>> +		if (ei->line_name)
>> +			scnprintf(ei->line_name, HTE_TS_NAME_LEN, "ts_%u",
>> +				  desc->attr.line_id);
>> +	}
>> +
>> +	hte_ts_dbgfs_init(desc->attr.name == NULL ?
>> +			  ei->line_name : desc->attr.name, ei);
>> +	set_bit(HTE_TS_REGISTERED, &ei->flags);
>> +
>> +	mutex_unlock(&ei->req_mlock);
>> +
>> +	dev_dbg(gdev->chip->dev, "id: %u, xlated id:%u",
>> +		desc->attr.line_id, xlated_id);
>> +
>> +	return 0;
>> +
>> +unlock:
>> +	module_put(gdev->owner);
>> +	mutex_unlock(&ei->req_mlock);
>> +
>> +	return ret;
>> +}
> ...
>> +/**
>> + * hte_push_ts_ns() - Push timestamp data in nanoseconds.
>> + *
>> + * It is used by the provider to push timestamp data.
>> + *
>> + * @chip: The HTE chip, used during the registration.
>> + * @xlated_id: entity id understood by both subsystem and provider, this is
>> + * obtained from xlate callback during request API.
>> + * @data: timestamp data.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
>> +		   struct hte_ts_data *data)
>> +{
>> +	hte_return_t ret;
>> +	int st = 0;
>> +	struct hte_ts_info *ei;
>> +	unsigned long flag;
>> +
>> +	if (!chip || !data || !chip->gdev)
>> +		return -EINVAL;
>> +
>> +	if (xlated_id > chip->nlines)
>> +		return -EINVAL;
>> +
>> +	ei = &chip->gdev->ei[xlated_id];
>> +
>> +	spin_lock_irqsave(&ei->slock, flag);
>> +
>> +	/* timestamp sequence counter */
>> +	data->seq = ei->seq++;
>> +
>> +	if (!test_bit(HTE_TS_REGISTERED, &ei->flags) ||
>> +	    test_bit(HTE_TS_DISABLE, &ei->flags)) {
>> +		dev_dbg(chip->dev, "Unknown timestamp push\n");
>> +		atomic_inc(&ei->dropped_ts);
>> +		st = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	ret = ei->cb(data, ei->cl_data);
>> +	if (ret == HTE_RUN_THREADED_CB && ei->thread) {
>> +		if (test_and_set_bit(HTE_CB_RUN_THREAD, &ei->hte_cb_flags))
>> +			goto unlock;
>> +		else
>> +			wake_up_process(ei->thread);
> 			queue_work(system_unbound_wq, &ei->cb_work);
>> +	}
>> +
>> +unlock:
>> +	spin_unlock_irqrestore(&ei->slock, flag);
>> +
>> +	return st;
>> +}
>> +EXPORT_SYMBOL_GPL(hte_push_ts_ns);
