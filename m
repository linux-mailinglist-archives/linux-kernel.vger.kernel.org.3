Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF65248FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbiELJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352066AbiELJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:32:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31834612B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652347934; x=1683883934;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aW0Rod2eR4xATFm3sX0mtGWGDxZADj+tdMGIwjWgVbQ=;
  b=DbLgzqxh8298Km/5SkHxTP9zFKDp4zW2R9nnu1wQtalZqNPK9m3780hj
   iH+py8/KAKBdpfe/sZU1ecHFx+xS3LGQueAXNLI5H5mJncjs8VILu43dO
   pGbN2UTV5SHhrn3MPV+39rJuxzdTlhtpjyCfbsIsT64dh2pF253b7dYdr
   dCtii+FPnaeSdXw8ezKH7Cw90bDnOqptQDeHnIVxgKR65Fc+JbIN7Mhg6
   MEzVmUopFufZANODWtgO9OpwC8m6guhbzPjtyCtBB5kgh/afIyksrqVum
   767hzJYwISAGnVnkFP3h+nTrKGAc+0wWTO1i/neZpPwQnBPOYJSlcOHcV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="252001890"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="252001890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:32:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="566599992"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.14]) ([10.255.30.14])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:32:11 -0700
Subject: Re: [kbuild-all] Re: [amir73il:fsnotify-fixes 2/2]
 fs/notify/fsnotify.c:540 fsnotify() warn: variable dereferenced before check
 'dir1' (see line 499)
To:     Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>
References: <202205080346.m0fb3UXK-lkp@intel.com>
 <CAOQ4uxiuF7qfUjmSHu1RgwcEhDvbU9nA6nFpMXCmrZ9qE4c4rw@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b88f78e4-8f79-ae93-151d-368f5070b666@intel.com>
Date:   Thu, 12 May 2022 17:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiuF7qfUjmSHu1RgwcEhDvbU9nA6nFpMXCmrZ9qE4c4rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2022 7:48 PM, Amir Goldstein wrote:
> On Mon, May 9, 2022 at 1:09 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> tree:   https://github.com/amir73il/linux fsnotify-fixes
>> head:   d25f3ce8da49ce1a3b0a0621f0bf7b1d6ba2dad6
>> commit: d25f3ce8da49ce1a3b0a0621f0bf7b1d6ba2dad6 [2/2] fsnotify: send FS_RENAME to groups watching the moved inode
>> config: s390-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220508/202205080346.m0fb3UXK-lkp@intel.com/config)
>> compiler: s390-linux-gcc (GCC) 11.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> smatch warnings:
>> fs/notify/fsnotify.c:540 fsnotify() warn: variable dereferenced before check 'dir1' (see line 499)
>>
>> vim +/dir1 +540 fs/notify/fsnotify.c
>>
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  475  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  476               const struct qstr *file_name, struct inode *inode, u32 cookie)
>> 90586523eb4b34 Eric Paris              2009-05-21  477  {
>> b54cecf5e2293d Amir Goldstein          2020-06-07  478          const struct path *path = fsnotify_data_path(data, data_type);
>> 29335033c574a1 Gabriel Krisman Bertazi 2021-10-25  479          struct super_block *sb = fsnotify_data_sb(data, data_type);
>> 3427ce71554123 Miklos Szeredi          2017-10-30  480          struct fsnotify_iter_info iter_info = {};
>> 60f7ed8c7c4d06 Amir Goldstein          2018-09-01  481          struct mount *mnt = NULL;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  482          struct inode *dir1, *dir2;
>> e54183fa7047c1 Amir Goldstein          2021-11-29  483          struct dentry *moved;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  484          int dir1_type = 0;
>> 9385a84d7e1f65 Jan Kara                2016-11-10  485          int ret = 0;
>> 71d734103edfa2 Mel Gorman              2020-07-08  486          __u32 test_mask, marks_mask;
>> 90586523eb4b34 Eric Paris              2009-05-21  487
>> 71d734103edfa2 Mel Gorman              2020-07-08  488          if (path)
>> aa93bdc5500cc9 Amir Goldstein          2020-03-19  489                  mnt = real_mount(path->mnt);
>> 3a9fb89f4cd04c Eric Paris              2009-12-17  490
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  491          if (!inode) {
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  492                  /* Dirent event - report on TYPE_INODE to dir */
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  493                  inode = dir;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  494          } else if (mask & FS_RENAME) {
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  495                  /* For FS_RENAME, dir1 is old_dir and dir2 is new_dir */
>> e54183fa7047c1 Amir Goldstein          2021-11-29  496                  moved = fsnotify_data_dentry(data, data_type);
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  497                  dir1 = moved->d_parent->d_inode;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  498                  dir2 = dir;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07 @499                  if (dir1->i_fsnotify_marks || dir2->i_fsnotify_marks)
>>                                                                              ^^^^^^^^^^^^^^^^^^^^^^
>> Dereference
>>
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  500                          dir1_type = FSNOTIFY_ITER_TYPE_OLD_DIR;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  501                  /*
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  502                   * Send FS_RENAME to groups watching the moved inode itself
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  503                   * only if the moved inode is a non-dir.
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  504                   * Sending FS_RENAME to a moved watched directory would be
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  505                   * confusing and FS_MOVE_SELF provided enough information to
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  506                   * track the movements of a watched directory.
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  507                   */
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  508                  if (mask & FS_ISDIR)
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  509                          inode = NULL;
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  510          } else if (mask & FS_EVENT_ON_CHILD) {
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  511                  /*
>> fecc4559780d52 Amir Goldstein          2020-12-02  512                   * Event on child - report on TYPE_PARENT to dir if it is
>> fecc4559780d52 Amir Goldstein          2020-12-02  513                   * watching children and on TYPE_INODE to child.
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  514                   */
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  515                  dir1 = dir;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  516                  dir2 = NULL;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  517                  if (dir1->i_fsnotify_marks)
>>                                                                              ^^^^^^^^^^^^^^^^^^^^^^
>> Dereference
>>
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  518                          dir1_type = FSNOTIFY_ITER_TYPE_PARENT;
>> 40a100d3adc1ad Amir Goldstein          2020-07-22  519          }
>> 497b0c5a7c0688 Amir Goldstein          2020-07-16  520
>> 7c49b8616460eb Dave Hansen             2015-09-04  521          /*
>> 7c49b8616460eb Dave Hansen             2015-09-04  522           * Optimization: srcu_read_lock() has a memory barrier which can
>> 7c49b8616460eb Dave Hansen             2015-09-04  523           * be expensive.  It protects walking the *_fsnotify_marks lists.
>> 7c49b8616460eb Dave Hansen             2015-09-04  524           * However, if we do not walk the lists, we do not have to do
>> 7c49b8616460eb Dave Hansen             2015-09-04  525           * SRCU because we have no references to any objects and do not
>> 7c49b8616460eb Dave Hansen             2015-09-04  526           * need SRCU to keep them "alive".
>> 7c49b8616460eb Dave Hansen             2015-09-04  527           */
>> 9b93f33105f5f9 Amir Goldstein          2020-07-16  528          if (!sb->s_fsnotify_marks &&
>> 497b0c5a7c0688 Amir Goldstein          2020-07-16  529              (!mnt || !mnt->mnt_fsnotify_marks) &&
>> 9b93f33105f5f9 Amir Goldstein          2020-07-16  530              (!inode || !inode->i_fsnotify_marks) &&
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  531              !dir1_type)
>> 7c49b8616460eb Dave Hansen             2015-09-04  532                  return 0;
>> 71d734103edfa2 Mel Gorman              2020-07-08  533
>> 9b93f33105f5f9 Amir Goldstein          2020-07-16  534          marks_mask = sb->s_fsnotify_mask;
>> 71d734103edfa2 Mel Gorman              2020-07-08  535          if (mnt)
>> 71d734103edfa2 Mel Gorman              2020-07-08  536                  marks_mask |= mnt->mnt_fsnotify_mask;
>> 9b93f33105f5f9 Amir Goldstein          2020-07-16  537          if (inode)
>> 9b93f33105f5f9 Amir Goldstein          2020-07-16  538                  marks_mask |= inode->i_fsnotify_mask;
>> d25f3ce8da49ce Amir Goldstein          2022-05-07  539          if (dir1_type) {
>> d25f3ce8da49ce Amir Goldstein          2022-05-07 @540                  if (dir1)
>>
>> If "dir1_type" is set then we have already dereferenced "dir1".  I guess
>> this unnecessary NULL check is something that probably wouldn't bother
>> a human reader too much...
> 
> True !!dir1_type means !!dir1.
> We could get rid of if (dir1)
> but I should note that I did not post this patch for review, this is an untested
> patch that I pushed to a branch on my private github.
> It is very generous of kbuild testbot to test any branch I push to my
> private github,
> but as much as I can recall, I never asked for it...

Hi Amir,

Sorry for the trouble, we'll only send the report to you privately.

Best Regards,
Rong Chen

> 
> Thanks,
> Amir.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
