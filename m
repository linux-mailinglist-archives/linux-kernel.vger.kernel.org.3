Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6158F63F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiHKDDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiHKDDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:03:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55DC1B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:03:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B2grpd028283;
        Thu, 11 Aug 2022 03:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ORUsdMLQlpcFxEkLSifdi6ooex9hh0jrofOJ8Ossr6o=;
 b=beMSzRaGutI53LvryiT1EoT198oQl5SMx35cGkf5v2tPhqHr5HAVPGLn2koxxo1PnPdo
 CZkED8TVsy5lQBMDa0UhzPTz50vW9pm3cynElpCw8FQTteCg9W72SiCFMi3lPQD7QzgF
 uU3eklEm04yDdN2TxOv7kghrmmkZH4FKM/q4g2wWl6msG14asatI3U2RbFiqxFmCQEYi
 yH5jiM/2WAnuVERsu9ZOTmgUTRZQsDms3xGktqWnt/vZoPQh2LM198T39hk8uF1tAxiz
 aSK0XmrlcA2kqTzc1nUsas1wDmfpHMClfNNGV/3UjbdIjKcRCLHeTyeC9AkGBSkT8QwS yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqg4k8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 03:03:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27B33095022663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 03:03:00 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 20:03:00 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 20:02:57 -0700
Message-ID: <54f974fb-f334-78cf-d5f5-198810cc77b4@quicinc.com>
Date:   Thu, 11 Aug 2022 11:02:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v6] mm/page_owner.c: add llseek for page_owner
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <akpm@linux-foundation.org>,
        <vbabka@kernel.org>
CC:     <kbuild-all@lists.01.org>, <minchan@kernel.org>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220810013218.27416-1-quic_yingangl@quicinc.com>
 <202208101628.o6qUzx50-lkp@intel.com>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <202208101628.o6qUzx50-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nUbreeS9hpmPjI7NkNAjdLA5VcdYsGT2
X-Proofpoint-GUID: nUbreeS9hpmPjI7NkNAjdLA5VcdYsGT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_02,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=904
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110006
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Vlastimil:


On 8/10/2022 5:02 PM, kernel test robot wrote:
> Hi Kassey,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on v5.19]
> [also build test ERROR on next-20220810]
> [cannot apply to akpm-mm/mm-everything linus/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
> base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
> config: parisc-buildonly-randconfig-r004-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101628.o6qUzx50-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/d2decd69a8d5756c1706092c805a4c8af14df471
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
>          git checkout d2decd69a8d5756c1706092c805a4c8af14df471
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from mm/page_owner.c:16:
>>> mm/../fs/proc/internal.h:51:9: error: unknown type name 'proc_write_t'
>        51 |         proc_write_t write;
>           |         ^~~~~~~~~~~~

# CONFIG_PROC_FS is not set in some arch, so we can not directly include 
the header file.
+#include "../fs/proc/internal.h"

how about add an extern  ? or do you have other suggest  ?

> 
> 
> vim +/proc_write_t +51 mm/../fs/proc/internal.h
> 
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  19
> 59d8053f1e1690 David Howells     2013-04-11  20  /*
> 59d8053f1e1690 David Howells     2013-04-11  21   * This is not completely implemented yet. The idea is to
> 59d8053f1e1690 David Howells     2013-04-11  22   * create an in-memory tree (like the actual /proc filesystem
> 59d8053f1e1690 David Howells     2013-04-11  23   * tree) of these proc_dir_entries, so that we can dynamically
> 59d8053f1e1690 David Howells     2013-04-11  24   * add new files to /proc.
> 59d8053f1e1690 David Howells     2013-04-11  25   *
> 710585d4922fd3 Nicolas Dichtel   2014-12-10  26   * parent/subdir are used for the directory structure (every /proc file has a
> 710585d4922fd3 Nicolas Dichtel   2014-12-10  27   * parent, but "subdir" is empty for all non-directory entries).
> 710585d4922fd3 Nicolas Dichtel   2014-12-10  28   * subdir_node is used to build the rb tree "subdir" of the parent.
> 59d8053f1e1690 David Howells     2013-04-11  29   */
> 59d8053f1e1690 David Howells     2013-04-11  30  struct proc_dir_entry {
> 163cf548db8887 Alexey Dobriyan   2018-02-06  31  	/*
> 163cf548db8887 Alexey Dobriyan   2018-02-06  32  	 * number of callers into module in progress;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  33  	 * negative -> it's going away RSN
> 163cf548db8887 Alexey Dobriyan   2018-02-06  34  	 */
> 163cf548db8887 Alexey Dobriyan   2018-02-06  35  	atomic_t in_use;
> 9cdd83e3100651 Alexey Dobriyan   2018-04-10  36  	refcount_t refcnt;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  37  	struct list_head pde_openers;	/* who did ->open, but not ->release */
> 53f63345d893df Alexey Dobriyan   2018-02-06  38  	/* protects ->pde_openers and all struct pde_opener instances */
> 53f63345d893df Alexey Dobriyan   2018-02-06  39  	spinlock_t pde_unload_lock;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  40  	struct completion *pde_unload_completion;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  41  	const struct inode_operations *proc_iops;
> d56c0d45f0e27f Alexey Dobriyan   2020-02-03  42  	union {
> d56c0d45f0e27f Alexey Dobriyan   2020-02-03  43  		const struct proc_ops *proc_ops;
> d56c0d45f0e27f Alexey Dobriyan   2020-02-03  44  		const struct file_operations *proc_dir_ops;
> d56c0d45f0e27f Alexey Dobriyan   2020-02-03  45  	};
> 1fde6f21d90f8b Alexey Dobriyan   2019-02-01  46  	const struct dentry_operations *proc_dops;
> 3f3942aca6da35 Christoph Hellwig 2018-05-15  47  	union {
> fddda2b7b52118 Christoph Hellwig 2018-04-13  48  		const struct seq_operations *seq_ops;
> 3f3942aca6da35 Christoph Hellwig 2018-05-15  49  		int (*single_show)(struct seq_file *, void *);
> 3f3942aca6da35 Christoph Hellwig 2018-05-15  50  	};
> 564def71765caf David Howells     2018-05-18 @51  	proc_write_t write;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  52  	void *data;
> 44414d82cfe0f6 Christoph Hellwig 2018-04-24  53  	unsigned int state_size;
> 59d8053f1e1690 David Howells     2013-04-11  54  	unsigned int low_ino;
> 59d8053f1e1690 David Howells     2013-04-11  55  	nlink_t nlink;
> 59d8053f1e1690 David Howells     2013-04-11  56  	kuid_t uid;
> 59d8053f1e1690 David Howells     2013-04-11  57  	kgid_t gid;
> 59d8053f1e1690 David Howells     2013-04-11  58  	loff_t size;
> 710585d4922fd3 Nicolas Dichtel   2014-12-10  59  	struct proc_dir_entry *parent;
> 4f1134370a29a5 Alexey Dobriyan   2018-04-10  60  	struct rb_root subdir;
> 710585d4922fd3 Nicolas Dichtel   2014-12-10  61  	struct rb_node subdir_node;
> b4884f23331ae3 Alexey Dobriyan   2018-04-10  62  	char *name;
> 163cf548db8887 Alexey Dobriyan   2018-02-06  63  	umode_t mode;
> d919b33dafb3e2 Alexey Dobriyan   2020-04-06  64  	u8 flags;
> 59d8053f1e1690 David Howells     2013-04-11  65  	u8 namelen;
> 24074a35c5c975 David Howells     2018-06-13  66  	char inline_name[];
> 3859a271a003ab Kees Cook         2016-10-28  67  } __randomize_layout;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  68
> 
