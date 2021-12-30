Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811AC481873
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhL3CTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:19:13 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:1600 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234483AbhL3CTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:19:11 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPX5V6pKpz1RvTj
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:19:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640830750; x=1643422751; bh=BPpWkccSKIgrcf0cDlidapfuRegV9CyAihl
        qz4L387U=; b=RZV3y/TDyS/TX/l15rFF6QqlrfjNT5Xq4gbYn6DpuOHXPbPhwiW
        mx/Ft+mJg5c1R1oj2Exf6xyzJJNmn5+RRZmaNK0MQNV/4nFh+DG31FRMhPlFXBem
        H3HvQuTLVMPT+ksWRLHFDWjXRn6FP5rWVxC93tecqFPsi4WcwNsM8/wLhZ00meEE
        N1pOMQ738HI3YOZZgxAtS03lyKSUMb9FXsTFFUdrHxs4FswaSSMDZE4AZM8pQifn
        MxPm1rU0Fzoj6c0oXUUEaheKy20p9XKZcHr7zsR61ONLX/msttHU6pRZDAACRs2N
        z9x0zoLNfQ+dQD0GFGyNRNOJGMlarpBDB6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9yfYWhFzTMGO for <linux-kernel@vger.kernel.org>;
        Wed, 29 Dec 2021 18:19:10 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPX5T3SrZz1RtVG;
        Wed, 29 Dec 2021 18:19:09 -0800 (PST)
Message-ID: <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 11:19:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211229161119.1006-3-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 01:11, Paul Menzel wrote:
> Since the first commit 1da177e4c3 (Linux-2.6.12-rc2) in the Linux git
> repository, `sata_link_resume()` contains a 200 ms delay with the comme=
nt
> below.
>=20
>>    /*
>>     * Some PHYs react badly if SStatus is pounded
>>     * immediately after resuming.  Delay 200ms before
>>     * debouncing.
>>     */

This is code comment so no need to "quote" this in the commit message
(line starting with '>'). Seeing the patch in an email client, it looks
weird :)

>=20
> A lot of PHYs do not have that problem though, so delaying 200 ms incre=
ases
> the boot time by 30 percent unnecessarily for a lot of systems, making
> =E2=80=9Cinstant booting=E2=80=9D quite hard.
>=20
> As it=E2=80=99s unknown for what PHY the delay was added, create a new =
board
> `board_ahci_nodbdelay` with the link flag `ATA_LFLAG_NO_DB_DELAY,`, and=
,
> for now, configure the AMD A85 FCH (Hudson D4) to use it.
>=20
> On the ASUS F2A85-M PRO it reduces the Linux kernel boot time by the
> expected 200 ms from 787 ms to 585 ms.
>=20
> Tested on ASUS F2A85-M PRO:
>=20
> Without patch, i. e., with 200 ms debounce delay:
>=20
>     [=E2=80=A6]
>     [    0.000000] DMI: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 4.15-671-g7b=
043ef855 12/27/2021
>     [=E2=80=A6]
>     [    0.404885] ahci 0000:00:11.0: version 3.0
>     [    0.405466] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6=
 Gbps 0x40 impl SATA mode
>     [    0.405470] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led cl=
o pio
>     [    0.408036] scsi host0: ahci
>     [    0.408537] scsi host1: ahci
>     [    0.408932] scsi host2: ahci
>     [    0.409444] scsi host3: ahci
>     [    0.409841] scsi host4: ahci
>     [    0.410266] scsi host5: ahci
>     [    0.410661] scsi host6: ahci
>     [    0.411052] scsi host7: ahci
>     [    0.411284] ata1: DUMMY
>     [    0.411286] ata2: DUMMY
>     [    0.411286] ata3: DUMMY
>     [    0.411287] ata4: DUMMY
>     [    0.411288] ata5: DUMMY
>     [    0.411289] ata6: DUMMY
>     [    0.411291] ata7: SATA max UDMA/133 abar m2048@0xf01cc000 port 0=
xf01cc400 irq 19
>     [    0.411292] ata8: DUMMY
>     [=E2=80=A6]
>     [    0.422362] Key type encrypted registered
>     [    0.424903] PM:   Magic number: 1:28:636
>     [    0.723979] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    0.724268] ata7.00: ATA-9: SanDisk SDSSDP064G, 2.0.0, max UDMA/=
133
>     [    0.724271] ata7.00: 125045424 sectors, multi 1: LBA48 NCQ (dept=
h 32)
>     [    0.725537] ata7.00: configured for UDMA/133
>     [    0.725898] scsi 6:0:0:0: Direct-Access     ATA      SanDisk SDS=
SDP06 0    PQ: 0 ANSI: 5
>     [    0.726428] sd 6:0:0:0: [sda] 125045424 512-byte logical blocks:=
 (64.0 GB/59.6 GiB)
>     [    0.726442] sd 6:0:0:0: [sda] Write Protect is off
>     [    0.726446] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
>     [    0.726464] sd 6:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
>     [    0.727985]  sda: sda1 sda2 sda3
>     [    0.728588] sd 6:0:0:0: [sda] Attached SCSI disk
>     [    0.738495] EXT4-fs (sda3): mounted filesystem with ordered data=
 mode. Opts: (null). Quota mode: none.
>     [=E2=80=A6]
>     [    0.786812] Run /sbin/init as init process
>=20
> With patch, i. e., skipping the debounce delay saves 200 ms from the bo=
ot
> as expected.
>=20
>     [=E2=80=A6]
>     [    0.000000] DMI: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 4.15-671-g7b=
043ef855 12/27/2021
>     [=E2=80=A6]
>     [    0.407372] ahci 0000:00:11.0: version 3.0
>     [    0.407909] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6=
 Gbps 0x40 impl SATA mode
>     [    0.407913] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led cl=
o pio
>     [    0.410520] scsi host0: ahci
>     [    0.411017] scsi host1: ahci
>     [    0.411418] scsi host2: ahci
>     [    0.411810] scsi host3: ahci
>     [    0.412225] scsi host4: ahci
>     [    0.412614] scsi host5: ahci
>     [    0.413005] scsi host6: ahci
>     [    0.413488] scsi host7: ahci
>     [    0.413713] ata1: DUMMY
>     [    0.413715] ata2: DUMMY
>     [    0.413716] ata3: DUMMY
>     [    0.413716] ata4: DUMMY
>     [    0.413717] ata5: DUMMY
>     [    0.413718] ata6: DUMMY
>     [    0.413720] ata7: SATA max UDMA/133 abar m2048@0xf01cc000 port 0=
xf01cc400 irq 19
>     [    0.413722] ata8: DUMMY
>     [=E2=80=A6]
>     [    0.425414] Key type encrypted registered
>     [    0.427873] PM:   Magic number: 1:234:838
>     [    0.522131] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    0.522415] ata7.00: ATA-9: SanDisk SDSSDP064G, 2.0.0, max UDMA/=
133
>     [    0.522418] ata7.00: 125045424 sectors, multi 1: LBA48 NCQ (dept=
h 32)
>     [    0.523636] ata7.00: configured for UDMA/133
>     [    0.523993] scsi 6:0:0:0: Direct-Access     ATA      SanDisk SDS=
SDP06 0    PQ: 0 ANSI: 5
>     [    0.524497] sd 6:0:0:0: [sda] 125045424 512-byte logical blocks:=
 (64.0 GB/59.6 GiB)
>     [    0.524511] sd 6:0:0:0: [sda] Write Protect is off
>     [    0.524515] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
>     [    0.524534] sd 6:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
>     [    0.525953]  sda: sda1 sda2 sda3
>     [    0.526541] sd 6:0:0:0: [sda] Attached SCSI disk
>     [    0.536245] EXT4-fs (sda3): mounted filesystem with ordered data=
 mode. Opts: (null). Quota mode: none.
>     [=E2=80=A6]
>     [    0.585327] Run /sbin/init as init process
>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Guenter Roeck <groeck@chromium.org>
>=20
> ---
>=20
> Add the two Chromium OS developers Dmitry and Guenter to Cc, as to my
> knowledge Chromium/Chrome OS also tries to boot very fast, and the Chro=
mium
> project has some CI infrastructure.
> ---
>  drivers/ata/ahci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 6a2432e4adda..4f3e0603864d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -51,6 +51,7 @@ enum board_ids {
>  	board_ahci,
>  	board_ahci_ign_iferr,
>  	board_ahci_mobile,
> +	board_ahci_nodbdelay,

The "nodb" naming is not super clear...
Maybe change the name to:

board_ahci_no_debounce_delay

or

board_ahci_no_resume_delay

?

Longer, but clearer.

>  	board_ahci_nomsi,
>  	board_ahci_noncq,
>  	board_ahci_nosntf,
> @@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_info[]=
 =3D {
>  		.udma_mask	=3D ATA_UDMA6,
>  		.port_ops	=3D &ahci_ops,
>  	},
> +	[board_ahci_nodbdelay] =3D {
> +		.flags		=3D AHCI_FLAG_COMMON,
> +		.link_flags	=3D ATA_LFLAG_NO_DB_DELAY,
> +		.pio_mask	=3D ATA_PIO4,
> +		.udma_mask	=3D ATA_UDMA6,
> +		.port_ops	=3D &ahci_ops,
> +	},
>  	[board_ahci_nomsi] =3D {
>  		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>  		.flags		=3D AHCI_FLAG_COMMON,
> @@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  		board_ahci_al },
>  	/* AMD */
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_ahci_n=
odbdelay },

Patch 1 introduces this macro in pci_ids.h, but it is used only here. So
to keep with the current style in this structure, drop the macro (so
drop patch 1).

>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>  	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine=
 */
>  	/* AMD is using RAID class only for ahci controllers */


--=20
Damien Le Moal
Western Digital Research
