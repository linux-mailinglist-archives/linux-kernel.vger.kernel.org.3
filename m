Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DCC49C79A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiAZKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:31:59 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:58864 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239993AbiAZKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643193111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zfh8QnBZQM2x2CENrZagbM9/XHpgDzvm6oNWm1HMP8=;
        b=Z8AEF99NnC5rA0gvyTJJRb+Gr4N1C8NVyMof9M6gwyD8Y5Pk62bvF930FbmHcqESE0O9pm
        qriUjeUKCJJYIiOpcZDZrTaRb9DCZ7J56IVJsLOqoBJ/n/kJQ+VxLrGnOfECF+/LhLH9S6
        R44QlTjzVSqqCtrCFlJYUGR3cilAtOI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-4FAWycyGPr-X_dD6JmObkw-3; Wed, 26 Jan 2022 11:31:50 +0100
X-MC-Unique: 4FAWycyGPr-X_dD6JmObkw-3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSpq6eWww6l9LCg9hf/LZJEeHZicFWzHNyZ7OwHKBRfaOtB7AhETtEnmz8G4xKGIFySVeWRccNHaKnlUveu2uiRh3ZYyxr6a/FIcsRNMTolouqnd2o/mdDdOLiYqcC2Uv+m8aiYXvUIVGZ/DiGhx8DZerUXITAo6zAXR8dDCoZlTtCqmf3Xl1I8DkSBwxIm34nWv3ZwHhzQ9IQ1sgHXwfXiTM5BB6ZAbAVKMQaSeSCLdnVDm+5mfRVJDya/zgHBwjKC00gpe/4L6vjAPul3laGTMHfIfKwjnF7PI2E7J5Ee2HIy/Phug1TdqmBaZ6bSEQzQIGIewXBKdX3CicWh5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zfh8QnBZQM2x2CENrZagbM9/XHpgDzvm6oNWm1HMP8=;
 b=VFWouOn2tFzPuTgdloLL9BVm1W+Id3r90Pk0fxl8OYeSuNh5P7QgwBtyZcU6iJXvGBTQoUbrrGLNTXduvIfZIwseXicrXUseLpCqpYztYQ7aKe7p3rSk3WIMdDCpw3hkZDvKrKR9ZENo+bnN3HzM0ZoKM2CQ56c7H3jsJdCLlF9yDqdjAfgj7ccN1aWSkYONRjdywXk90QQr3MBjJFQVEf/xYM52cmSUC/TtD4bagqKgy8uy8QLt/aaG/rfoUnEzahnq5d6D5FwUzsPJfkDsmCQg97SeQpTWoCsktjJnhReBirWf8Ck8T4aeemZ3T2HKQ5QkAFsiVhyYSLqQFmcnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:31:46 +0000
Received: from AM7PR04MB7013.eurprd04.prod.outlook.com
 ([fe80::dd9f:243e:b87b:d4f5]) by AM7PR04MB7013.eurprd04.prod.outlook.com
 ([fe80::dd9f:243e:b87b:d4f5%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 10:31:45 +0000
Message-ID: <1076a789-76f5-b451-ede3-d0fc283d8616@suse.com>
Date:   Wed, 26 Jan 2022 10:31:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [kdave-btrfs-devel:misc-next 149/153] fs/btrfs/tree-log.c:6755:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
References: <202201260759.edlA9lHT-lkp@intel.com>
From:   Filipe Manana <fdmanana@suse.com>
In-Reply-To: <202201260759.edlA9lHT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::32) To AM7PR04MB7013.eurprd04.prod.outlook.com
 (2603:10a6:20b:116::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba8183b-840d-4519-7340-08d9e0b70d37
X-MS-TrafficTypeDiagnostic: VI1PR04MB7006:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB7006E26D959AA9316D752338AB209@VI1PR04MB7006.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qeq6Kx3HoqOmgnxCcTdiueCaIAvAAAyhdzyDHxEFR8jZEc4mKtckGGD4nJJJDhEi1jxYVtA874ooxZ1B+Gq57C2w3Rdr5VVV2/NG9w/kGHcpjWnt2AsQnR8dietzN28xb7Kx9FEywa3/PXK3RcTL6iDvvi+GnKbzHhhiz/lmsn2qHNUn5SnsGtu3q3ed+sv3oFjSwvovMRotLcDdqKV2Z+AtWXnluPQHA3vZXZJWiqMytsHdevIawSL8Q0nRr/W99Bz8cVWfPAOvtfbi1qzq0IaoDuOj9SnKVWsishPZAF2uo3XPz7DnlyegTaaoHM1sJo3bff7F5bNhOSeizOJBmy8Qt7Mc1ugnVXIwDRvLtLV16L/3vgFosrr+2CZGHCU9XZ1fw2AlzITc8eqYCAoSOYSuM/MmxIk+TYTEAoTCOSQniYH+BRuIeiY5yhhfFtLsv+Ogw79WJa403llRJLrJj+eXli9K/VNkvGnqdmoPYEZJlCGBgqvpGX2mwL4HhcUSVK4UYkkyfZ6OhYpfCRFHJjYfPKli0ZGlAajhpWBDjxwXDnsaJ1f0cUgFatlYqw8KInligrD/p+0/EEPvpezH/g/vQPtgTcnT52f+SI39qsqD3baM198Hubx+KBrUORdXy5jTXoK1YKDDMeb36nrFZoY3R0V271TLqxQRaop1JLchGZxlExqzyXh9zy86hmV757ymIujN8gBTphCWTxaxyWvGlMl0RLxmhDZrFpI7guhNHpA5VMbuAYpHcfAAtvIumH4BONOC7iqU28ku45q8pPkD9NLVu5AaCHf07+gycvZmZR+ZD9znGt416xEMb2CJqQEX4neTfyzUnAnUg9nYhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(38100700002)(36756003)(66946007)(5660300002)(66556008)(6916009)(316002)(8936002)(31686004)(8676002)(6506007)(6486002)(966005)(83380400001)(31696002)(6512007)(508600001)(53546011)(86362001)(186003)(2616005)(2906002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVCcEZZOWJQdEVOc1FWdjFJckVoUERFU1J1UDEyLzNhU1RlODF0VE04RVJK?=
 =?utf-8?B?UWxNQVRSbURtQTg4Q2VkUHNsYTRCdHFpa1ZjM3AyQlVvYVA1WXBXUkQ0b2lI?=
 =?utf-8?B?NXhtM0pXa0lSN09PMG5icEZMNkF2UGp5UDExSVlxZjM5SGI4WDRmR3JNd1BZ?=
 =?utf-8?B?TTJhRi9JYjJXV3NSL3NpWE1IRWNpYzFqaC82UTNqNmxmR0Ezc2lMc1AwS0pD?=
 =?utf-8?B?eFB1NmhzMWtWQjYySGpkdkx1QTF0dytUY1pXS1FLTi9sa2dMUVk2MlNkbksr?=
 =?utf-8?B?UEF0d3pWa2lTQU04Q1JkQURWZEVQbmQvZlBxak13Q0FuRFlMc1d2d1lTUjM5?=
 =?utf-8?B?Z1hjRHk1NEw4NzdkTDhwMDZROXlmUnQrTWd5ZjVjT3JzTFRiQ0JOMU5DVitG?=
 =?utf-8?B?UkVnaEpPQ3lXbW0rRnJTdHFXZWc3LzdKOXQvbWRwTFNIS05EbjFJRk1nZlgy?=
 =?utf-8?B?MzN4SHNCNHh3VzFlMUMwcVRhWTRuNkhyOU5DR2E5czFETDc3Z3ZRQlJtUHJW?=
 =?utf-8?B?VitxcW5PdUpLK2FsNm5yeUNMYWxXRURpeW1nZ01CbXFod25QWXJPVnd1TGZR?=
 =?utf-8?B?b0JaaS85U1JqaFYyNjNsOVgyL3hQWmhua2VFNGh6VzdtVS84eEMrK1dYRkQy?=
 =?utf-8?B?SVhIQ1grSXdWUXZmUjZ3Ujl2dWVwWGpqRmRZOHYzQXNJQmtjTTlMTHc4RENN?=
 =?utf-8?B?NU1QZmZTOFNISi9UclFSWnFUQnFJZ3dMaHJ2am9LRk5uSDlVMkUyNTZDdkk0?=
 =?utf-8?B?OVpnSTVWSHpIRkxTdXJHVkJyWTNrakxEbHprNUFDLzNab2FhODVVaG12TGx2?=
 =?utf-8?B?MXNDdnZDUEZTR1kwODNRN01zR09HSllwRDFVbWVJeFRKcW1yMCtpZHplSFlY?=
 =?utf-8?B?QVYvQ3BpT0lMZ2RrcFhVZm1BMzlpZTBjVUlhd0oycFVVdGlzQk5UdldJVy80?=
 =?utf-8?B?dU1WMWtoMEdJRnluWkNOd1FnZjFKOTRNK3pJME5BcVQ1N0NKUlg1MjRIa1JL?=
 =?utf-8?B?TFo0RmczVEcyMmwxTWErb0JIL1p6azN0VktUREM3RTVLUXREL3dKVUNHSjhu?=
 =?utf-8?B?U1ZsSENnOFpBWUtEVS9EMmdCZDZJdlZtd0E0Q2dvM2VXZGFaclR5MjZZTjA3?=
 =?utf-8?B?dmsxaXp3THJsRHh0UzZGVlYxZktoQlk5MjlhY0svQW92Z29DbXQ0TUthRlVi?=
 =?utf-8?B?NmxaYnB1UnQ1R2xHUDlRNnJUVkYrbTQvaTFhT1NNRDVYMXp4ZHBuclF3Q0hs?=
 =?utf-8?B?QmlxWEpIYXVZR2JHN3RnMExlUE5qYldob2RTcXBNL1kyc1NwZVpDa3B2TUY0?=
 =?utf-8?B?b0tlaGlibW1FcmNtNXR4Z3ZXS3M3MXkvTWVnNm1OeEpYb0hvZ1F6R0t2LzRV?=
 =?utf-8?B?QjVqNUgxZktNVldBcnJLaHI0Ym1Za2g5VWMwRTY2WThwTjgzU042WUZldzl1?=
 =?utf-8?B?bjFaWFRncm03T09BRU1RMXU0T1VoZ1JxWW85VlVTUmFNV00vWHN0VjdhQXhT?=
 =?utf-8?B?RTFKdlNucXZVdzJIazg0cWVxU2R0SklhM0dFZlUvNXpEK1laZFg0T056MXpF?=
 =?utf-8?B?UVJWMGJKbUkzQVJYOHFwMjZSLytjVVZ1TE1lS1NwZmVqQVhybzVESWJrS1c1?=
 =?utf-8?B?MC9Dd2gveWQwYmVJRTlpZnJFc1JFT1FTQithUDQyQjRsY0h5cWppeVlvYVRX?=
 =?utf-8?B?dmZ2b1F2SWlVdEQvNzdURlh3WDk2cnYxNHRrV3R3MmQyeThBYWxYMjJCNXRw?=
 =?utf-8?B?aEFMMDV0ZDVDcWZjNUlEQk1NZmFLUWdCejM4R29Ra0ZpeVZTSm5vSkFGQmZq?=
 =?utf-8?B?UThtMWczNUdkM1oyWWhTaTZQUzhyT3VvS1hEQ1JMRGduY2I1Qk1ncTJHT3JO?=
 =?utf-8?B?cmEzdlBzMVE2M1lvQTJqN29GWGN3K0IyZzlRYmlOeThRWEI0WnJsbEtnU1Jo?=
 =?utf-8?B?VTM5TDEreFUwaTN3V2xhSTJVMHIvcXR6RGdQblV6RzNoZU4xRTVTWUJSYWlE?=
 =?utf-8?B?V3NJS0kzVlVYRDJFMWtXaHN4SHVEY01KNXVOY1c0a2pRWC9xd3JQYzBaVzdY?=
 =?utf-8?B?M1hvK2pEcVl0UFFwWUZQWmcrK3Q4TVl2VlFmbmlGWE1XODJXTWFYTEROS1lu?=
 =?utf-8?B?THJyaVJFVEVZV3F5MEJPcXFzZ0VFNHJIUklnK3JtYXUvSHpKZU1XMEs5d0VH?=
 =?utf-8?B?MzVkNDFVaFpTVGpmTnJhMEMzTFR4RS9qejlzNVNiNFZiOVdIenRXK1h3aTNi?=
 =?utf-8?Q?JwFM2/X3Lo8UgFbK/0jX5jNAeUvCNObz/r/yrCbeOQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba8183b-840d-4519-7340-08d9e0b70d37
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:31:45.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vsvylT6p/QcwbiuvNo5BnUwdrMB/Sn+pr2d56e7WdmSZ/rIFTl7cGYrlc2BeAjVqJXnSoPZDy7xV6PEfEvXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/22 23:12, kernel test robot wrote:
> tree:   https://github.com/kdave/btrfs-devel.git misc-next
> head:   8e5d6a5c062f370d4d0b2dace7e95ab40c6ce3dd
> commit: 6bfc5d45946acd8286fb026137f20ee8747a50f1 [149/153] btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
> config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201260759.edlA9lHT-lkp@intel.com/config)
> compiler: nds32le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/kdave/btrfs-devel/commit/6bfc5d45946acd8286fb026137f20ee8747a50f1
>         git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
>         git fetch --no-tags kdave-btrfs-devel misc-next
>         git checkout 6bfc5d45946acd8286fb026137f20ee8747a50f1
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/btrfs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> fs/btrfs/tree-log.c:6755: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Update the log after adding a new name for an inode.
> 
> 
> vim +6755 fs/btrfs/tree-log.c
> 
>   6753	
>   6754	/**
>> 6755	 * Update the log after adding a new name for an inode.

The patch I submitted did not add the "/**":

https://lore.kernel.org/linux-btrfs/1f0d5aaf498afa64ef3582cb9d9d24bc5f888ab2.1642676248.git.fdmanana@suse.com/T/#u

However I see that David's misc-next branch, the patch adds that:

https://github.com/kdave/btrfs-devel/commit/6bfc5d45946acd8286fb026137f20ee8747a50f1

David, did you edit the patch? Why?

thanks

>   6756	 *
>   6757	 * @trans:              Transaction handle.
>   6758	 * @old_dentry:         The dentry associated with the old name and the old
>   6759	 *                      parent directory.
>   6760	 * @old_dir:            The inode of the previous parent directory for the case
>   6761	 *                      of a rename. For a link operation, it must be NULL.
>   6762	 * @parent:             The dentry associated with the directory under which the
>   6763	 *                      new name is located.
>   6764	 *
>   6765	 * Call this after adding a new name for an inode, as a result of a link or
>   6766	 * rename operation, and it will properly update the log to reflect the new name.
>   6767	 */
>   6768	void btrfs_log_new_name(struct btrfs_trans_handle *trans,
>   6769				struct dentry *old_dentry, struct btrfs_inode *old_dir,
>   6770				struct dentry *parent)
>   6771	{
>   6772		struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
>   6773		struct btrfs_log_ctx ctx;
>   6774	
>   6775		/*
>   6776		 * this will force the logging code to walk the dentry chain
>   6777		 * up for the file
>   6778		 */
>   6779		if (!S_ISDIR(inode->vfs_inode.i_mode))
>   6780			inode->last_unlink_trans = trans->transid;
>   6781	
>   6782		/*
>   6783		 * if this inode hasn't been logged and directory we're renaming it
>   6784		 * from hasn't been logged, we don't need to log it
>   6785		 */
>   6786		if (!inode_logged(trans, inode) &&
>   6787		    (!old_dir || !inode_logged(trans, old_dir)))
>   6788			return;
>   6789	
>   6790		/*
>   6791		 * If we are doing a rename (old_dir is not NULL) from a directory that
>   6792		 * was previously logged, make sure the next log attempt on the directory
>   6793		 * is not skipped and logs the inode again. This is because the log may
>   6794		 * not currently be authoritative for a range including the old
>   6795		 * BTRFS_DIR_INDEX_KEY key, so we want to make sure after a log replay we
>   6796		 * do not end up with both the new and old dentries around (in case the
>   6797		 * inode is a directory we would have a directory with two hard links and
>   6798		 * 2 inode references for different parents). The next log attempt of
>   6799		 * old_dir will happen at btrfs_log_all_parents(), called through
>   6800		 * btrfs_log_inode_parent() below, because we have previously set
>   6801		 * inode->last_unlink_trans to the current transaction ID, either here or
>   6802		 * at btrfs_record_unlink_dir() in case the inode is a directory.
>   6803		 */
>   6804		if (old_dir)
>   6805			old_dir->logged_trans = 0;
>   6806	
>   6807		btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
>   6808		ctx.logging_new_name = true;
>   6809		/*
>   6810		 * We don't care about the return value. If we fail to log the new name
>   6811		 * then we know the next attempt to sync the log will fallback to a full
>   6812		 * transaction commit (due to a call to btrfs_set_log_full_commit()), so
>   6813		 * we don't need to worry about getting a log committed that has an
>   6814		 * inconsistent state after a rename operation.
>   6815		 */
>   6816		btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
>   6817	}
>   6818	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

