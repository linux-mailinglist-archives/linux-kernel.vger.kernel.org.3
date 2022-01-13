Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F159648D4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiAMJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiAMJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:26:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30DC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:26:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x6so17334602lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yx+30Y1K4pYNY2f/mcZBWt2Ae8oilwcNjJm0iPRAVQU=;
        b=B7I9/XQR8BsL/ai1bajBV+0LHrfqSslUQnx6/rFccgKd+j+13TrgSqzuygm/ImiKKM
         1YoOA3wAEHhxp8IqsCrlQ8YcrsKnCO0Z3yZI51vhgk1KLATNJCL9/wD0ir8LSTiphD86
         c45ClYOzkwVP+nWIPvGQLYIlTWZab1/wgD1uvsf6vwyqRCrLyMN/rlD6JOODtIrGKJGi
         bYide8VogDHEorW3Xt6aohVar6/ZPJ/tPSDxZu+ff53M2KGNblPRNwRjUnruaFeQQmEH
         Du8s69i2WYye8S/Kv8DNYIGxK5URF5g6fOeY7/kzl7n6eIuw6TFv0835BEBqH5L9uCYs
         LOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yx+30Y1K4pYNY2f/mcZBWt2Ae8oilwcNjJm0iPRAVQU=;
        b=brf1SIs/YmyjbrhNZm0CmOE8vqbusgyMXDoRCzDc7cM3am0MSWiOgfN3gvORyIL5GB
         4kx8gxZWM4eKSRLwGvZdLte0eyCo8hntQHNC2TSTjtZxSni05YxAnJRfrvd+Kr7o2yQJ
         GAH/IXE3264p7K3BpD6xPedD94AA1/7HfkHxS9hdjsAHh06wtyjta3C3h3fbsFtG13UZ
         +/VO5qyKluUfkgzMAhqF53Pk6C2ju5ZA8ZHlLY1l+i7zLrl4x7X9V7kTCLR19PH8qnGI
         c0u19PX062VVPRMhxZuF2PWQJErLGV1zXZp59r4WfiOhsOy444DO44DzDbElg4L8HK1T
         zR2Q==
X-Gm-Message-State: AOAM533fVTZlv3icoAzlWjSQ7VGjb079YsQHXmsIK5Z1p3LuZI3KIqIc
        L4bMNepWBEEPx17PDq0Z2saOl4Veo14cBdhLKbFyHQ==
X-Google-Smtp-Source: ABdhPJwD1H5MT0KiHsCIZMNalAQON7ZfeubUMsrNU6nrbL3YD25efcbPYVmfy3KCAa0X8jJ7mL+i4hwvFeRT4rpRwyg=
X-Received: by 2002:a05:6512:2350:: with SMTP id p16mr2752577lfu.336.1642066008554;
 Thu, 13 Jan 2022 01:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220107121215.1912-2-yinxin.x@bytedance.com> <202201091544.W5HHEXAp-lkp@intel.com>
 <CAK896s74jBKAhruo-v8rJGWDOgTKF6GKNWg5Qj0B+Zb=VAtJdA@mail.gmail.com>
 <CAD+ocbwyE=h3jFnanQRqkh+AemCv8aP2W9J92C4OoV047TZS7Q@mail.gmail.com>
 <CAK896s7kbDtieyHregY2U-Y_nZBixmNAa6pAyoenb_fy_sD_3w@mail.gmail.com> <20220113085939.es3eboxmbiocz6kf@riteshh-domain>
In-Reply-To: <20220113085939.es3eboxmbiocz6kf@riteshh-domain>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Thu, 13 Jan 2022 17:26:37 +0800
Message-ID: <CAK896s4joD9+M_8Qb_oaMpVOZFup=g1Re5YL42z+nR-mEh9P4g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ext4: fast commit may not fallback for
 ineligible commit
To:     riteshh <riteshh@linux.ibm.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:59 PM riteshh <riteshh@linux.ibm.com> wrote:
>
> On 22/01/13 02:53PM, Xin Yin wrote:
> > On Thu, Jan 13, 2022 at 12:18 PM harshad shirwadkar
> > <harshadshirwadkar@gmail.com> wrote:
> > >
> > > On Mon, Jan 10, 2022 at 7:13 PM Xin Yin <yinxin.x@bytedance.com> wrote:
> > > >
> > > > Hi Dan,
> > > >
> > > > Thanks for spotting this, and I think it is not only an
> > > > 'uninitialized' issue , we can not use 'handle' after
> > > > ext4_journal_stop,  it may cause a use-after-free.
> > > > So maybe we should use 'transaction tid' as input instead of 'handle',
> > > > then it will be like this ext4_fc_mark_ineligible(struct super_block
> > > > *sb, int reason, tid_t tid). or we should move all
> > > > ext4_fc_mark_ineligible() between ext4_journal_start/ext4_journal_stop
> > > > if we need 'handle' param.
> > > This is a case where the inode is still in the fast commit list and we
> > > reached the "no_delete" case in ext4_evict_inode. Note that we reach
> > > here even when we are not able to start the journal handle. So, the
> > > second option that you suggested (to move ext4_fc_mark_ineligible()
> > > between ext4_journal_start() and ext4_journal_stop()) would not work
> > > for the case when we are not able to start the handle at all. Also,
> > > passing handle to ext4_fc_mark_ineligible() is pretty clean so I'd
> > > like to stay with that instead of passing "tid".
> > Understood, thanks for the explanations.
> >
> > >
> > > How about adding a new variant of ext4_fc_mark_ineligible() that
> > > doesn't take handle and only takes sb and reason? In that function we
> > > can mark the currently running transaction as ineligible. So basically
> > > it would derive tid as journal->j_running_transaction->t_tid. We can
> > Yes , this makes sense , thanks.
> >
> > > name that function as something like "ext4_fc_mark_txn_ineligible()".
> > In this case , I think we can just set "hendle" as NULL , then
> > ext4_fc_mark_ineligible() use tid as
> > journal->j_running_transaction->t_tid. And we do not need to add a new
> > API. How about this?
>
> I was about to comment the same that why two different APIs for the same work.
> Above does sounds a better solution to me. But I will let Harshad
> comment on it too.
>
> Also please note in function ext4_xattr_set(), with fstests, I could easily
> reproduce a use-after-free issue with your v2 patches too.
Thanks , this is the same reason as the issue reported by Dan , I will
fix this in the next version. could you share the fstests command to
reproduce this issue?

Thanks,
Xin Yin
>
>
> -ritesh
>
>
>
> >
> > > >
> > > > Hi Harshad, could you give some advice?  it seems you also need to
> > > > change this part in your following patches.
> > > >
> > > > Thanks,
> > > > Xin Yin
> > > >
> > > > On Mon, Jan 10, 2022 at 5:23 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > Hi Xin,
> > > > >
> > > > > url:    https://github.com/0day-ci/linux/commits/Xin-Yin/ext4-fix-issues-when-fast-commit-work-with-jbd/20220107-201314
> > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > > > > config: x86_64-randconfig-m001-20220107 (https://download.01.org/0day-ci/archive/20220109/202201091544.W5HHEXAp-lkp@intel.com/config)
> > > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > >
> > > > > New smatch warnings:
> > > > > fs/ext4/inode.c:340 ext4_evict_inode() error: uninitialized symbol 'handle'.
> > > > >
> > > > > vim +/handle +340 fs/ext4/inode.c
> > > > >
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  167  void ext4_evict_inode(struct inode *inode)
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  168  {
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  169       handle_t *handle;
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  170       int err;
> > > > > 65db869c754e7c Jan Kara           2019-11-05  171       /*
> > > > > 65db869c754e7c Jan Kara           2019-11-05  172        * Credits for final inode cleanup and freeing:
> > > > > 65db869c754e7c Jan Kara           2019-11-05  173        * sb + inode (ext4_orphan_del()), block bitmap, group descriptor
> > > > > 65db869c754e7c Jan Kara           2019-11-05  174        * (xattr block freeing), bitmap, group descriptor (inode freeing)
> > > > > 65db869c754e7c Jan Kara           2019-11-05  175        */
> > > > > 65db869c754e7c Jan Kara           2019-11-05  176       int extra_credits = 6;
> > > > > 0421a189bc8cde Tahsin Erdogan     2017-06-22  177       struct ext4_xattr_inode_array *ea_inode_array = NULL;
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  178       bool freeze_protected = false;
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  179
> > > > > 7ff9c073dd4d72 Theodore Ts'o      2010-11-08  180       trace_ext4_evict_inode(inode);
> > > > > 2581fdc810889f Jiaying Zhang      2011-08-13  181
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  182       if (inode->i_nlink) {
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  183               /*
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  184                * When journalling data dirty buffers are tracked only in the
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  185                * journal. So although mm thinks everything is clean and
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  186                * ready for reaping the inode might still have some pages to
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  187                * write in the running transaction or waiting to be
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  188                * checkpointed. Thus calling jbd2_journal_invalidatepage()
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  189                * (via truncate_inode_pages()) to discard these buffers can
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  190                * cause data loss. Also even if we did not discard these
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  191                * buffers, we would have no way to find them after the inode
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  192                * is reaped and thus user could see stale data if he tries to
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  193                * read them before the transaction is checkpointed. So be
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  194                * careful and force everything to disk here... We use
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  195                * ei->i_datasync_tid to store the newest transaction
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  196                * containing inode's data.
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  197                *
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  198                * Note that directories do not have this problem because they
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  199                * don't use page cache.
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  200                */
> > > > > 6a7fd522a7c94c Vegard Nossum      2016-07-04  201               if (inode->i_ino != EXT4_JOURNAL_INO &&
> > > > > 6a7fd522a7c94c Vegard Nossum      2016-07-04  202                   ext4_should_journal_data(inode) &&
> > > > > 3abb1a0fc2871f Jan Kara           2017-06-22  203                   (S_ISLNK(inode->i_mode) || S_ISREG(inode->i_mode)) &&
> > > > > 3abb1a0fc2871f Jan Kara           2017-06-22  204                   inode->i_data.nrpages) {
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  205                       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  206                       tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  207
> > > > > d76a3a77113db0 Theodore Ts'o      2013-04-03  208                       jbd2_complete_transaction(journal, commit_tid);
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  209                       filemap_write_and_wait(&inode->i_data);
> > > > > 2d859db3e4a82a Jan Kara           2011-07-26  210               }
> > > > > 91b0abe36a7b2b Johannes Weiner    2014-04-03  211               truncate_inode_pages_final(&inode->i_data);
> > > > > 5dc23bdd5f846e Jan Kara           2013-06-04  212
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  213               goto no_delete;
> > > > >
> > > > > Assume we hit this goto
> > > > >
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  214       }
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  215
> > > > > e2bfb088fac03c Theodore Ts'o      2014-10-05  216       if (is_bad_inode(inode))
> > > > > e2bfb088fac03c Theodore Ts'o      2014-10-05  217               goto no_delete;
> > > > > 871a293155a245 Christoph Hellwig  2010-03-03  218       dquot_initialize(inode);
> > > > > 907f4554e2521c Christoph Hellwig  2010-03-03  219
> > > > > 678aaf481496b0 Jan Kara           2008-07-11  220       if (ext4_should_order_data(inode))
> > > > > 678aaf481496b0 Jan Kara           2008-07-11  221               ext4_begin_ordered_truncate(inode, 0);
> > > > > 91b0abe36a7b2b Johannes Weiner    2014-04-03  222       truncate_inode_pages_final(&inode->i_data);
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  223
> > > > > ceff86fddae874 Jan Kara           2020-04-21  224       /*
> > > > > ceff86fddae874 Jan Kara           2020-04-21  225        * For inodes with journalled data, transaction commit could have
> > > > > ceff86fddae874 Jan Kara           2020-04-21  226        * dirtied the inode. Flush worker is ignoring it because of I_FREEING
> > > > > ceff86fddae874 Jan Kara           2020-04-21  227        * flag but we still need to remove the inode from the writeback lists.
> > > > > ceff86fddae874 Jan Kara           2020-04-21  228        */
> > > > > ceff86fddae874 Jan Kara           2020-04-21  229       if (!list_empty_careful(&inode->i_io_list)) {
> > > > > ceff86fddae874 Jan Kara           2020-04-21  230               WARN_ON_ONCE(!ext4_should_journal_data(inode));
> > > > > ceff86fddae874 Jan Kara           2020-04-21  231               inode_io_list_del(inode);
> > > > > ceff86fddae874 Jan Kara           2020-04-21  232       }
> > > > > ceff86fddae874 Jan Kara           2020-04-21  233
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  234       /*
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  235        * Protect us against freezing - iput() caller didn't have to have any
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  236        * protection against it. When we are in a running transaction though,
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  237        * we are already protected against freezing and we cannot grab further
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  238        * protection due to lock ordering constraints.
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  239        */
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  240       if (!ext4_journal_current_handle()) {
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  241               sb_start_intwrite(inode->i_sb);
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  242               freeze_protected = true;
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  243       }
> > > > > e50e5129f384ae Andreas Dilger     2017-06-21  244
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  245       if (!IS_NOQUOTA(inode))
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  246               extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  247
> > > > > 65db869c754e7c Jan Kara           2019-11-05  248       /*
> > > > > 65db869c754e7c Jan Kara           2019-11-05  249        * Block bitmap, group descriptor, and inode are accounted in both
> > > > > 65db869c754e7c Jan Kara           2019-11-05  250        * ext4_blocks_for_truncate() and extra_credits. So subtract 3.
> > > > > 65db869c754e7c Jan Kara           2019-11-05  251        */
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  252       handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE,
> > > > > 65db869c754e7c Jan Kara           2019-11-05  253                        ext4_blocks_for_truncate(inode) + extra_credits - 3);
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  254       if (IS_ERR(handle)) {
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  255               ext4_std_error(inode->i_sb, PTR_ERR(handle));
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  256               /*
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  257                * If we're going to skip the normal cleanup, we still need to
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  258                * make sure that the in-core orphan linked list is properly
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  259                * cleaned up.
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  260                */
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  261               ext4_orphan_del(NULL, inode);
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  262               if (freeze_protected)
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  263                       sb_end_intwrite(inode->i_sb);
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  264               goto no_delete;
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  265       }
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  266
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  267       if (IS_SYNC(inode))
> > > > > 0390131ba84fd3 Frank Mayhar       2009-01-07  268               ext4_handle_sync(handle);
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  269
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  270       /*
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  271        * Set inode->i_size to 0 before calling ext4_truncate(). We need
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  272        * special handling of symlinks here because i_size is used to
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  273        * determine whether ext4_inode_info->i_data contains symlink data or
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  274        * block mappings. Setting i_size to 0 will remove its fast symlink
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  275        * status. Erase i_data so that it becomes a valid empty block map.
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  276        */
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  277       if (ext4_inode_is_fast_symlink(inode))
> > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  278               memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  279       inode->i_size = 0;
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  280       err = ext4_mark_inode_dirty(handle, inode);
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  281       if (err) {
> > > > > 12062dddda4509 Eric Sandeen       2010-02-15  282               ext4_warning(inode->i_sb,
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  283                            "couldn't mark inode dirty (err %d)", err);
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  284               goto stop_handle;
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  285       }
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  286       if (inode->i_blocks) {
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  287               err = ext4_truncate(inode);
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  288               if (err) {
> > > > > 54d3adbc29f0c7 Theodore Ts'o      2020-03-28  289                       ext4_error_err(inode->i_sb, -err,
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  290                                      "couldn't truncate inode %lu (err %d)",
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  291                                      inode->i_ino, err);
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  292                       goto stop_handle;
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  293               }
> > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  294       }
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  295
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  296       /* Remove xattr references. */
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  297       err = ext4_xattr_delete_inode(handle, inode, &ea_inode_array,
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  298                                     extra_credits);
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  299       if (err) {
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  300               ext4_warning(inode->i_sb, "xattr delete (err %d)", err);
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  301  stop_handle:
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  302               ext4_journal_stop(handle);
> > > > > 4538821993f448 Theodore Ts'o      2010-07-29  303               ext4_orphan_del(NULL, inode);
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  304               if (freeze_protected)
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  305                       sb_end_intwrite(inode->i_sb);
> > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  306               ext4_xattr_inode_array_free(ea_inode_array);
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  307               goto no_delete;
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  308       }
> > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  309
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  310       /*
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  311        * Kill off the orphan record which ext4_truncate created.
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  312        * AKPM: I think this can be inside the above `if'.
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  313        * Note that ext4_orphan_del() has to be able to cope with the
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  314        * deletion of a non-existent orphan - this is because we don't
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  315        * know if ext4_truncate() actually created an orphan record.
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  316        * (Well, we could do this if we need to, but heck - it works)
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  317        */
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  318       ext4_orphan_del(handle, inode);
> > > > > 5ffff834322281 Arnd Bergmann      2018-07-29  319       EXT4_I(inode)->i_dtime  = (__u32)ktime_get_real_seconds();
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  320
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  321       /*
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  322        * One subtle ordering requirement: if anything has gone wrong
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  323        * (transaction abort, IO errors, whatever), then we can still
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  324        * do these next steps (the fs will already have been marked as
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  325        * having errors), but we can't free the inode if the mark_dirty
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  326        * fails.
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  327        */
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  328       if (ext4_mark_inode_dirty(handle, inode))
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  329               /* If that failed, just do the required in-core inode clear. */
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  330               ext4_clear_inode(inode);
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  331       else
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  332               ext4_free_inode(handle, inode);
> > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  333       ext4_journal_stop(handle);
> > > > > 46e294efc355c4 Jan Kara           2020-11-27  334       if (freeze_protected)
> > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  335               sb_end_intwrite(inode->i_sb);
> > > > > 0421a189bc8cde Tahsin Erdogan     2017-06-22  336       ext4_xattr_inode_array_free(ea_inode_array);
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  337       return;
> > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  338  no_delete:
> > > > > b21ebf143af219 Harshad Shirwadkar 2020-11-05  339       if (!list_empty(&EXT4_I(inode)->i_fc_list))
> > > > >
> > > > > It's not clear without more context where this ->i_fc_list list is
> > > > > modified.
> > > > >
> > > > > db40129f85538a Xin Yin            2022-01-07 @340               ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, handle);
> > > > >
> > > > > "handle" might be uninitialized?
> > > > >
> > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  341       ext4_clear_inode(inode);        /* We must guarantee clearing of inode... */
> > > > > 9d0be50230b333 Theodore Ts'o      2010-01-01  342  }
> > > > >
> > > > > ---
> > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > > >
