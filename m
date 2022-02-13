Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B64B3C17
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiBMPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiBMPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:34:56 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B35F8D2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 07:34:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 21C5E58012C;
        Sun, 13 Feb 2022 10:34:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 13 Feb 2022 10:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UA8T6JiS2f3ocAFcD
        gjHyjxICxgUmp2Ip3lgkBm5b9k=; b=ahRWvieaYNmVdj3m2nCPuqkay7sl2L4ut
        BuMLw7cTlreuR8lIZh7gi4o/Fmre4X8afwjL79FXQdgh67v+JJYY+blDijP1fZsT
        PELmblx7syqCsp281VitTT0I5Lv/GtxiJJFgBjgkv43tJzDzznDxg954cJf/aRI6
        P930bt4poGLa+M0D8ioQT0wb8fDLA3ZAaUy6F4wnoffegOe9q9IGK3sn3cBFdm8q
        BfV43tR3WENkOWn4I5Nh8WFd58Ikn/O+o429UdrsG5zrh/CzZEIizHhFUO3tIK3b
        rePocJilix9hHlmqoijz1XesiGLMpZt6xchTOJDSJCpCOuAms/gwg==
X-ME-Sender: <xms:FCUJYvVWD523C5yxVO7jdLtY-OX7nBPv3HvHAdtGM60X7NzHurnTJw>
    <xme:FCUJYnlAeo9Ew5sUKf62pWHuDnChnKrHRjQOT4oO69ImfUmH3sdJYiArzyvoFUlvX
    QMUlyuLAXzbK8k>
X-ME-Received: <xmr:FCUJYraB5kFtZjdh-RDZQ3RBSscTSGnjU30IVALmi8z9skluvybwKVmtZY6nZW10koTA9mSbG8ETiH547puW-7ZZpeXqbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedtgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnheptdffkeekfeduffevgeeujeffjefhtefgueeugfevtdeiheduueeukefhudehleet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:FCUJYqUqWtSq8yN47UI41vHediP7TWziXt8gjR4lKUOmyu7E9whw1A>
    <xmx:FCUJYpkqFA8pd60dBGBDfXh-3YZeg7WD3sV08Vz2pfTMjFnY3iUpPQ>
    <xmx:FCUJYnc1zv3SmapGD31m0pXeZw8SN8DfsgTX7vfNKKtOUqug4d30Rw>
    <xmx:FyUJYp-0Bhr6JGHzk6NiYIcM9J8x86sDxavsbuuJEc6v6G5v4nCgLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Feb 2022 10:34:42 -0500 (EST)
Date:   Sun, 13 Feb 2022 17:34:38 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com, jani.nikula@linux.intel.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de, joonas.lahtinen@linux.intel.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mark@fasheh.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        phil@philpotter.co.uk, pjt@google.com, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        surenb@google.com, torvalds@linux-foundation.org, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [PATCH v2] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
Message-ID: <YgklDvNecca1/8in@shredder>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org>
 <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org>
 <YgNyAC8VMeuOD/uQ@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgNyAC8VMeuOD/uQ@dumbo>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:49:20AM +0100, Domenico Andreoli wrote:
>  fs/binfmt_misc.c |    6 +-----
>  fs/file_table.c  |    2 ++
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> Index: b/fs/binfmt_misc.c
> ===================================================================
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -817,20 +817,16 @@ static struct file_system_type bm_fs_typ
>  };
>  MODULE_ALIAS_FS("binfmt_misc");
>  
> -static struct ctl_table_header *binfmt_misc_header;
> -
>  static int __init init_misc_binfmt(void)
>  {
>  	int err = register_filesystem(&bm_fs_type);
>  	if (!err)
>  		insert_binfmt(&misc_format);
> -	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> -	return 0;
> +	return err;
>  }
>  
>  static void __exit exit_misc_binfmt(void)
>  {
> -	unregister_sysctl_table(binfmt_misc_header);
>  	unregister_binfmt(&misc_format);
>  	unregister_filesystem(&bm_fs_type);
>  }
> Index: b/fs/file_table.c
> ===================================================================
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[
>  static int __init init_fs_stat_sysctls(void)
>  {
>  	register_sysctl_init("fs", fs_stat_sysctls);
> +	if (IS_ENABLED(CONFIG_BINFMT_MISC))
> +		register_sysctl_mount_point("fs/binfmt_misc");

Hi,

kmemleak complains about this:

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8881045fea88 (size 96):
  comm "swapper/0", pid 1, jiffies 4294669355 (age 167.804s)
  hex dump (first 32 bytes):
    e0 c8 07 88 ff ff ff ff 00 00 00 00 01 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81d11637>] __register_sysctl_table+0x117/0x1150
    [<ffffffff86c3600f>] init_fs_stat_sysctls+0x30/0x33
    [<ffffffff81002558>] do_one_initcall+0x108/0x690
    [<ffffffff86bca8bd>] kernel_init_freeable+0x45a/0x4de
    [<ffffffff83e0757f>] kernel_init+0x1f/0x220
    [<ffffffff810048cf>] ret_from_fork+0x1f/0x30

>  	return 0;
>  }
>  fs_initcall(init_fs_stat_sysctls);
> 
