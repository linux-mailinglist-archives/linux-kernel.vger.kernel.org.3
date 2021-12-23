Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32A847E840
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhLWTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:19:06 -0500
Received: from relay032.a.hostedemail.com ([64.99.140.32]:53942 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233253AbhLWTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:19:04 -0500
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 7332A20303;
        Thu, 23 Dec 2021 19:19:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 5982520015;
        Thu, 23 Dec 2021 19:18:55 +0000 (UTC)
Message-ID: <228ca42e53c6db97d5972b90786f9dd30e3a56b5.camel@perches.com>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Thu, 23 Dec 2021 11:19:00 -0800
In-Reply-To: <20211223184856.v34ecibwzepahsju@uno.localdomain>
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
         <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
         <20211223184856.v34ecibwzepahsju@uno.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: py7xrhtk9fgs3zbiekogdxjf8ag7ipu1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5982520015
X-Spam-Status: No, score=-3.40
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18vRg5YHdWx/vRQzPDIInnA/39bgJ0Yc4Q=
X-HE-Tag: 1640287135-701640
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 19:48 +0100, Jacopo Mondi wrote:
> Hi Joe,
>   sorry to jump in

No worries.  It's all just a bikeshed and doesn't really matter
to the correctness of the code.

> On Thu, Dec 23, 2021 at 09:49:58AM -0800, Joe Perches wrote:
> > On Thu, 2021-12-23 at 08:06 +0100, Krzysztof Hałasa wrote:
> > > The driver has been extensively tested in an i.MX6-based system.
> > > AR0521 is a 5.7 mm x 4.3 mm, 5 MPix RGGB MIPI/HiSPi BSI CMOS sensor
> > > from On Semiconductor.
> > 
> > trivial notes:
> > 
> > > diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
> > []
> > > +/* External clock (extclk) frequencies */
> > > +#define AR0521_EXTCLK_MIN	  (10 * 1000 * 1000)
> > 
> > Generally, adding a prefix like AR0521_ to defines that are
> > locally defined in a single file unnecessarily increases
> > identifier length.
> > 
> > It makes using short line lengths difficult.
> > 
> > e.g. Using this identifier anywhere
> > 
> > > +#define AR0521_REG_HISPI_CONTROL_STATUS_FRAMER_TEST_MODE_ENABLE 0x80
> > 
> > Many of the 80 column line lengths and line wrapping used in this
> > file are not really nice to read.  I believe you don't have to be
> > strict about 80 column lines.
> > 
> 
> Krzysztof first version had much longer lines, and in facts it has
> been asked by me to reduce them to 80 cols. The media subsystem
> requires to validate patches with
> 
>         ./scripts/checkpatch.pl --strict --max-line-length=80
> 
> We longly debated this and I believe it's now generally accepted to go
> over 80 when it makes sense, but not regularly span to 120 cols like
> in the previous version.

IMO: Many of the lines here could be lengthened to < 100 to
improve readability.

> I think this 80-cols limit not being an hard limit anymore is doing
> more worse than good, as each subsystem applies a different rule, and
> I know how frustrating is for Krzysztof to be pushed in different
> direction, as the same happened to me when I contributed to other
> subsystems and I've been asked to span to 100 cols while I was trying
> to stay in 80 no matter what.

Up to you all.

But there's a tension between long identifiers and short lines.

And anything using a 55 character identifier basically guarantees
that the code will exceed 80 columns.

Using identifiers with 10 character or so is generally OK, but
there are dozens of longer identifiers specific to this code.

I'd suggest because of these long identifiers that the code
be restricted to 100 columns, but not strictly at 80.

And there are quite a few long lines in drivers/media/i2c and
espcially for drivers/media/

A few of them are grotesquely long.
Probably all of them are historic and don't warrant change.

Just for i2c:

$ git ls-files -- 'drivers/media/i2c/*.[ch]' | \
  xargs awk '{print length($0); }' | \
  sort -rn | uniq -c
      2 143
      1 141
      1 123
      4 118
      2 114
      1 111
      1 110
      1 109
      1 107
      1 105
      4 104
      2 102
      3 101
      1 100
      2 99
     11 98
      7 97
      8 96
      4 95
     11 94
      8 93
     19 92
     13 91
     28 90
     20 89
     28 88
     39 87
     18 86
     33 85
     42 84
     86 83
     38 82
     47 81
    167 80
    110 79
    155 78
    363 77
    230 76
    219 75
    217 74
    427 73
    695 72
    471 71
    538 70
    525 69
    679 68
    661 67
   1046 66
    757 65
   1002 64
    942 63
   1053 62
    967 61
   1018 60
   1132 59
   1307 58
   1366 57
   3206 56
   1240 55
   2191 54
   1829 53
   1719 52
   1503 51
   1795 50
   1714 49
   1640 48
   1567 47
   1550 46
   1880 45
   2155 44
   1780 43
   1880 42
   1854 41
   1962 40
   2031 39
   2009 38
   2022 37
   2240 36
   2252 35
   2152 34
   2178 33
   2074 32
   2185 31
   2462 30
   2478 29
   2186 28
   1988 27
   1846 26
   1926 25
   2177 24
   2048 23
   1804 22
   1267 21
   1414 20
   1563 19
   6154 18
   3619 17
   7222 16
   1682 15
   2685 14
   3037 13
   2142 12
   1704 11
   3013 10
   3191 9
   1609 8
    230 7
    461 6
    571 5
    878 4
   2790 3
   6524 2
   7732 1
  24729 0

And for all of drivers/media:

$ git ls-files -- 'drivers/media/*.[ch]' | \
  xargs awk '{print length($0);}' | \
  sort -rn | uniq -c
      1 338
      1 314
      1 268
      1 261
      1 255
      1 254
      1 242
      1 234
      1 228
      1 213
      1 207
      1 205
      1 198
      2 197
      3 192
      2 188
      2 177
      1 174
      2 172
      2 169
      3 168
      2 167
      1 166
      1 165
      1 164
      3 163
      2 162
      2 161
      2 160
      6 158
     10 157
      3 156
      2 155
      3 154
      2 153
     12 152
      8 151
     49 150
      4 148
      2 147
      3 146
      3 145
      5 144
      5 143
      1 142
      6 141
      7 140
      8 139
      6 138
     10 137
     14 136
     13 135
     14 134
     13 133
     11 132
      7 131
      6 130
     15 129
     21 128
     17 127
     13 126
     10 125
     13 124
     12 123
     25 122
     20 121
     25 120
     15 119
     18 118
     20 117
     23 116
     30 115
     23 114
     26 113
     35 112
     35 111
     40 110
     60 109
     50 108
     72 107
     42 106
     47 105
    105 104
     72 103
     90 102
    110 101
    144 100
     79 99
    122 98
    226 97
    644 96
    115 95
    135 94
    135 93
    166 92
    210 91
    227 90
    218 89
    208 88
    279 87
    292 86
   1260 85
   1122 84
    879 83
   1288 82
   1489 81
   2505 80
   6241 79
   3653 78
   5268 77
   2012 76
   2168 75
   2279 74
   3297 73
   4343 72
   3741 71
   4018 70
   4360 69
   4487 68
   4433 67
   6014 66
   6098 65
   6547 64
   6661 63
   7312 62
   7684 61
   7610 60
   8157 59
   9052 58
  10047 57
  12064 56
   9904 55
  11075 54
  11271 53
  13259 52
  11585 51
  15036 50
  13930 49
  15159 48
  14221 47
  13349 46
  14243 45
  15887 44
  17829 43
  16620 42
  17759 41
  17569 40
  16653 39
  17386 38
  17480 37
  18296 36
  18205 35
  18782 34
  18352 33
  18137 32
  19556 31
  19229 30
  19403 29
  19570 28
  19447 27
  19581 26
  19255 25
  19300 24
  17038 23
  18523 22
  15609 21
  16188 20
  14634 19
  19426 18
  20979 17
  21548 16
  13476 15
  16713 14
  18914 13
  17577 12
  12828 11
  19525 10
  21665 9
  13912 8
   3261 7
   5375 6
   6756 5
   8260 4
  23448 3
  48708 2
  55786 1
 182329 0


