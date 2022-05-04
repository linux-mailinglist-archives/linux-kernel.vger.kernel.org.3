Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDE5197E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiEDHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiEDHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:17:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182E622BF9;
        Wed,  4 May 2022 00:13:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:1b3c:6996:5378:f253]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nm9CM-00042j-Sr; Wed, 04 May 2022 09:13:23 +0200
Message-ID: <7c84392d-8ba9-e74e-256b-036b728e5568@leemhuis.info>
Date:   Wed, 4 May 2022 09:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
Content-Language: en-US
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Byron Stanoszek <gandalf@winds.org>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <sfrench@samba.org>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651648405;133b0c76;
X-HE-SMSGID: 1nm9CM-00042j-Sr
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v4.14..v5.16
#regzbot title cifs: regression mounting vers=1.0 NTLMSSP when hostname
is too long
#regzbot ignore-activity

If it turns out this isn't a regression, free free to remove it from the
tracking by sending a reply to this thread containing a paragraph like
"#regzbot invalid: reason why this is invalid" (without the quotes).

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. Regzbot needs them to
automatically connect reports with fixes, but they are useful in
general, too.

I'm sending this to everyone that got the initial report, to make
everyone aware of the tracking. I also hope that messages like this
motivate people to directly get at least the regression mailing list and
ideally even regzbot involved when dealing with regressions, as messages
like this wouldn't be needed then. And don't worry, if I need to send
other mails regarding this regression only relevant for regzbot I'll
send them to the regressions lists only (with a tag in the subject so
people can filter them away). With a bit of luck no such messages will
be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


On 03.05.22 22:36, Byron Stanoszek wrote:
> I would like to report a regression in the CIFS fs. Sometime between
> Linux 4.14
> and 5.16, mounting CIFS with option vers=1.0 (and
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y set appropriately) with security type
> NTLMSSP stopped working for me. The server side is a Windows 2003 Server.
> 
> I found that this behavior depends on the length of the Linux client's
> host+domain name (e.g. utsname()->nodename), where the mount works as
> long as
> the name is 16 characters or less. Anything 17 or above returns -EIO,
> per the
> following example:
> 
> /etc/fstab entry:
> 
> //10.0.0.12/xxxxxxxxx /ext0     cifs   
> vers=1.0,user=xxxxx,pass=xxxxxxxxxxx,dom=xxxxxxxxxxx,dir_mode=0755,file_mode=0644,noauto
> 0 0
> 
> # hostname 12345678901234567;mount /ext0
> mount error(5): Input/output error
> Refer to the mount.cifs(8) manual page (e.g. man mount.cifs) and kernel
> log messages (dmesg)
> # hostname 1234567890123456;mount /ext0
> #
> 
> I implemented a workaround using the following patch:
> 
> Signed-off-by: Byron Stanoszek <gandalf@winds.org>
> ---
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -101,7 +101,7 @@
>  #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
>  #endif
> 
> -#define CIFS_MAX_WORKSTATION_LEN  (__NEW_UTS_LEN + 1)  /* reasonable
> max for client */
> +#define CIFS_MAX_WORKSTATION_LEN 16
> 
>  /*
>   * CIFS vfs client Status information (based on what we know.)
> 
> I don't know if this patch is correct or will have any real effect
> outside of
> the NTLMSSP session connect sequence, but it worked in my case.
> 
> I appended a transcript of the CIFS debug log from Linux 5.17.5 showing
> this
> behavior. Server names are X'd out, and I highlighted the hostname as
> "12345678901234567890".
> 
> Thanks,
>  -Byron
> 
>  - - -
> 
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'source'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'ip'
> CIFS: address conversion returned 1 for 10.0.0.12
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'unc'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'vers'
> Use of the less secure dialect vers=1.0 is not recommended unless
> required for access to very old servers
> 
> CIFS: VFS: Use of the less secure dialect vers=1.0 is not recommended
> unless required for access to very old servers
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'user'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'pass'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'dom'
> CIFS: fs/cifs/fs_context.c: Domain name set
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'dir_mode'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'file_mode'
> CIFS: fs/cifs/fs_context.c: CIFS: parsing cifs mount option 'netbiosname'
> CIFS: fs/cifs/cifsfs.c: Devname: \\10.0.0.12\xxxxxxxxx flags: 0
> CIFS: fs/cifs/connect.c: Username: xxxxx
> CIFS: fs/cifs/connect.c: file mode: 0644  dir mode: 0755
> CIFS: fs/cifs/connect.c: VFS: in mount_get_conns as Xid: 104 with uid: 0
> CIFS: fs/cifs/connect.c: UNC: \\10.0.0.12\xxxxxxxxx
> CIFS: fs/cifs/connect.c: generic_ip_connect: connecting to 10.0.0.12:445
> CIFS: fs/cifs/connect.c: Socket created
> CIFS: fs/cifs/connect.c: sndbuf 16384 rcvbuf 131072 rcvtimeo 0x1b58
> CIFS: fs/cifs/connect.c: cifs_get_tcp_session: next dns resolution
> scheduled for 600 seconds in the future
> CIFS: fs/cifs/connect.c: VFS: in cifs_get_smb_ses as Xid: 105 with uid: 0
> CIFS: fs/cifs/connect.c: Existing smb sess not found
> CIFS: fs/cifs/cifssmb.c: Requesting extended security
> CIFS: fs/cifs/connect.c: Demultiplex PID: 6581
> CIFS: fs/cifs/transport.c: wait_for_free_credits: remove 1 credits total=0
> CIFS: fs/cifs/transport.c: For smb_command 114
> CIFS: fs/cifs/transport.c: Sending smb: smb_len=51
> 0000 2f00                                .../
> 53ff 424d 0072 0000 0000 c801 0000 0000  .SMBr...........
> 0000 0000 0000 0000 0000 19b3 0000 0001  ................
> 00 0c 00 02 4e 54 20 4c 4d 20 30 2e 31 32 00     ....NT LM 0.12.
> CIFS: fs/cifs/connect.c: RFC1002 header 0xb2
> 0000 b200 53ff 424d 0072 0000 9800 8001  .....SMBr.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 0000 0001 0011 0300 00fd 0001 8104 0000  ................
> 0000 0001 e4e2 692b d3fd 8000 79be a08c  ......+i.....y..
> 5f1b 01d8 012c 6d00 1500 0000 4200 e8c1  ._..,..m.....B..
> 3625 c892 1069 2669 6056 065b 2b06 0106  %6..i.i&V`[..+..
> 0505 a002 3051 a04f 3024 0622 2a09 4886  ....Q0O.$0"..*.H
> f782 0112 0202 0906 862a 8648 12f7 0201  ........*.H.....
> 0602 2b0a 0106 0104 3782 0202 a30a 3027  ...+.....7....'0
> a025 1b23 xx21 xxxx xxxx xxxx xxxx xxxx  %.#.!xxxxxxxxxxx
> 4024 xxxx xxxx xxxx xxxx xxxx xxxx xxxx  $@xxxxxxxxxxxxxx
> xxxx xxxx xxxx                           xxxxxx
> CIFS: fs/cifs/misc.c: checkSMB Length: 0xb6, smb_buf_length: 0xb2
> CIFS: fs/cifs/transport.c: cifs_sync_mid_result: cmd=114 mid=1 state=4
> 0000 b200 53ff 424d 0072 0000 9800 8001  .....SMBr.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 0000 0001 0011 0300 00fd 0001 8104 0000  ................
> 0000 0001 e4e2 692b d3fd 8000 79be a08c  ......+i.....y..
> 5f1b 01d8 012c 6d00 1500 0000 4200 e8c1  ._..,..m.....B..
> 3625 c892 1069 2669 6056 065b            %6..i.i&V`[.
> CIFS: fs/cifs/cifssmb.c: Dialect: 0
> CIFS: Max buf = 33028
> CIFS: fs/cifs/cifssmb.c: negprot rc 0
> CIFS: fs/cifs/connect.c: Security Mode: 0x3 Capabilities: 0x8000d3fd
> TimeAdjust: 18000
> CIFS: fs/cifs/sess.c: sess setup type 2
> CIFS: fs/cifs/sess.c: rawntlmssp session setup negotiate phase
> CIFS: fs/cifs/transport.c: wait_for_free_credits: remove 1 credits
> total=252
> CIFS: fs/cifs/transport.c: For smb_command 115
> CIFS: fs/cifs/transport.c: Sending smb: smb_len=194
> 0000 be00                                ....
> 53ff 424d 0073 0000 0000 d801 0000 0000  .SMBs...........
> 0000 0000 0000 0000 0000 19b3 0000 0002  ................
> ff0c 0000 5400 fd40 0100 0000 0000 2400  .....T@........$
> 00 00 00 00 00 dc d0 00 80 83 00                 ...........
> 544e 4d4c 5353 0050 0001 0000 8235 e008  NTLMSSP.....5...
> 0000 0000 0020 0000 0000 0000 0022 0000  .... ......."...
> 0000 0000                                ....
> 4c00 6900 6e00 7500 7800 2000 7600 6500  .L.i.n.u.x. .v.e
> 7200 7300 6900 6f00 6e00 2000 3500 2e00  .r.s.i.o.n. .5..
> 3100 3700 2e00 3500 0000 4300 4900 4600  .1.7...5...C.I.F
> 5300 2000 5600 4600 5300 2000 4300 6c00  .S. .V.F.S. .C.l
> 6900 6500 6e00 7400 2000 6600 6f00 7200  .i.e.n.t. .f.o.r
> 00 20 00 4c 00 69 00 6e 00 75 00 78 00 00 00     . .L.i.n.u.x...
> CIFS: fs/cifs/connect.c: RFC1002 header 0x154
> 0000 5401 53ff 424d 1673 0000 98c0 c807  ...T.SMBs.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 0800 0002 ff04 0000 0000 de00 2900 4e01  .............).N
> 4c54 534d 5053 0200 0000 0e00 0e00 3000  TLMSSP.........0
> 0000 0500 8982 6560 8fb0 4b2d 8980 002a  ......`e..-K..*.
> 0000 0000 0000 a000 a000 3e00 0000 XX00  ...........>...X
> XX00 XX00 XX00 XX00 XX00 XX00 0200 0e00  .X.X.X.X.X.X....
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 0100  .X.X.X.X.X.X.X..
> 1600 XX00 XX00 XX00 XX00 XX00 XX00 XX00  ...X.X.X.X.X.X.X
> XX00 XX00 XX00 XX00 0400 XX00 XX00 XX00  .X.X.X.X...X.X.X
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00  .X.X.X.X.X.X.X.X
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00  .X.X.X.X.X.X.X.X
> XX00 XX00 0300 XX00 XX00 XX00 XX00 XX00  .X.X...X.X.X.X.X
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00  .X.X.X.X.X.X.X.X
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00  .X.X.X.X.X.X.X.X
> XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00  .X.X.X.X.X.X.X.X
> XX00 XX00 XX00 XX00 0000 0000 0000 0057  .X.X.X.X......W.
> 0069 006e 0064 006f 0077 0073 0020 0035  i.n.d.o.w.s. .5.
> 002e 0030 0000 0057 0069 006e 0064 006f  ..0...W.i.n.d.o.
> 0077 0073 0020 0032 0030 0030 0030 0020  w.s. .2.0.0.0. .
> 004c 0041 004e 0020 004d 0061 006e 0061  L.A.N. .M.a.n.a.
> 0067 0065 0072 0000                      g.e.r...
> CIFS: fs/cifs/misc.c: checkSMB Length: 0x158, smb_buf_length: 0x154
> CIFS: fs/cifs/transport.c: cifs_sync_mid_result: cmd=115 mid=2 state=4
> 0000 5401 53ff 424d 1673 0000 98c0 c807  ...T.SMBs.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 0800 0002 ff04 0000 0000 de00 2900 4e01  .............).N
> 4c54 534d 5053 0200 0000 0e00 0e00 3000  TLMSSP.........0
> 0000 0500 8982 6560 8fb0 4b2d 8980 002a  ......`e..-K..*.
> 0000 0000 0000 a000 a000 3e00            ...........>
> CIFS: Status code returned 0xc0000016 NT_STATUS_MORE_PROCESSING_REQUIRED
> CIFS: fs/cifs/netmisc.c: Mapping smb error code 0xc0000016 to POSIX err -5
> CIFS: fs/cifs/misc.c: Null buffer passed to cifs_small_buf_release
> CIFS: fs/cifs/sess.c: rawntlmssp session setup challenge phase
> CIFS: fs/cifs/sess.c: UID = 2048
> CIFS: fs/cifs/sess.c: decode_ntlmssp_challenge: negotiate=0xe0088235
> challenge=0x60898205
> CIFS: fs/cifs/sess.c: rawntlmssp session setup authenticate phase
> CIFS: fs/cifs/transport.c: wait_for_free_credits: remove 1 credits
> total=252
> CIFS: fs/cifs/transport.c: For smb_command 115
> CIFS: fs/cifs/transport.c: Sending smb: smb_len=514
> 0000 fe01                                ....
> 53ff 424d 0073 0000 0000 d801 0000 0000  .SMBs...........
> 0000 0000 0000 0000 0000 19b3 0800 0003  ................
> ff0c 0000 5400 fd40 0100 0000 0000 6400  .....T@........d
> 01 00 00 00 00 dc d0 00 80 c3 01                 ...........
> 544e 4d4c 5353 0050 0003 0000 0000 0000  NTLMSSP.........
> 0040 0000 00cc 00cc 0040 0000 0016 0016  @.......@.......
> 010c 0000 000a 000a 0122 0000 0028 0028  ........"...(.(.
> 012c 0000 0010 0010 0154 0000 a205 6089  ,.......T......`
> 277e 10f2 c522 1143 c4d3 2343 28f2 5b32  ~'..".C...C#.(2[
> 0101 0000 0000 0000 2278 bb86 5f1b 01d8  ........x"..._..
> 66a8 9bd0 c591 0e07 0000 0000 0002 000e  .f..............
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 0001  X.X.X.X.X.X.X...
> 0016 00XX 00XX 00XX 00XX 00XX 00XX 00XX  ..X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 0004 00XX 00XX 00XX  X.X.X.X...X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 0003 00XX 00XX 00XX 00XX 00XX  X.X...@.X.X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 0000 0000 00XX 00XX  X.X.X.X.....X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 00XX 00XX  X.X.X.X.X.X.X.X.
> 00XX 00XX 00XX 00XX 00XX 00XX 0031 0032  X.X.X.X.X.X.1.2.
> 0033 0034 0035 0036 0037 0038 0039 0030  3.4.5.6.7.8.9.0.
> 0031 0032 0033 0034 0035 0036 0037 0038  1.2.3.4.5.6.7.8.
> 0039 0030 3063 e7c2 9bea b237 7fe3 a91f  9.0.c0....7.....
> ac5f e633                                _.3.
> 4c00 6900 6e00 7500 7800 2000 7600 6500  .L.i.n.u.x. .v.e
> 7200 7300 6900 6f00 6e00 2000 3500 2e00  .r.s.i.o.n. .5..
> 3100 3700 2e00 3500 0000 4300 4900 4600  .1.7...5...C.I.F
> 5300 2000 5600 4600 5300 2000 4300 6c00  .S. .V.F.S. .C.l
> 6900 6500 6e00 7400 2000 6600 6f00 7200  .i.e.n.t. .f.o.r
> 00 20 00 4c 00 69 00 6e 00 75 00 78 00 00 00     . .L.i.n.u.x...
> CIFS: fs/cifs/connect.c: RFC1002 header 0x23
> 0000 2300 53ff 424d 1673 0000 88c0 c001  ...#.SMBs.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 00 00 03 00 00 00 00                             .......
> CIFS: fs/cifs/misc.c: checkSMB Length: 0x27, smb_buf_length: 0x23
> CIFS: fs/cifs/transport.c: cifs_sync_mid_result: cmd=115 mid=3 state=4
> 0000 2300 53ff 424d 1673 0000 88c0 c001  ...#.SMBs.......
> 0000 0000 0000 0000 0000 0000 0000 19b3  ................
> 00 00 03 00 00 00 00                             .......
> CIFS: Status code returned 0xc0000016 NT_STATUS_MORE_PROCESSING_REQUIRED
> CIFS: fs/cifs/netmisc.c: Mapping smb error code 0xc0000016 to POSIX err -5
> CIFS: fs/cifs/misc.c: Null buffer passed to cifs_small_buf_release
> CIFS: VFS: \\10.0.0.12 Send error in SessSetup = -5
> CIFS: fs/cifs/connect.c: VFS: leaving cifs_get_smb_ses (xid = 105) rc = -5
> CIFS: fs/cifs/connect.c: VFS: leaving mount_put_conns (xid = 104) rc = 0
> CIFS: VFS: cifs_mount failed w/return code = -5
-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

