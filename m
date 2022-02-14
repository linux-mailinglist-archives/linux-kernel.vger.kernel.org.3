Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1C4B40D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiBNE3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:29:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBNE3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:29:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070094F449
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 20:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644812969; x=1676348969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L+fraMYSp4ITx/+fNvEWWfyE5f3pv7pi3dMt/rl48d8=;
  b=gkuGn4LjBRbEDkCM4fbTex7JLs1iCitTMVzYp9/hb0oqzr+/X27BwnMi
   bDNyWISL7oDVbXoZJlT4pYKTpsahAbdG1XYfns/7R+H6eOQli65AxOxhD
   1bQGP8UlaGHQDmdHgBE5XM+R7wkkTpNo3UkPR03EBhCE2CRrrYW8WdfYG
   6787CLN/jxBSdACWEH8jB2xpji29VugOQ4vx5ttNO4aRm3NpsgGVj7H+z
   6MWW7QFaGdR6Sug1S6SGobPQW5SwroaFZT9Z8TJIICTPHVBgqECTK/Ep4
   pmuxoTvE7maqxv0MG+yPi5TAwrZ7pW1gUaOPd0UPv0rZnFQYtae+IYk+B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336435476"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="336435476"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 20:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="527852942"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2022 20:29:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJSzO-0008BT-2j; Mon, 14 Feb 2022 04:29:26 +0000
Date:   Mon, 14 Feb 2022 12:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: [xiang:xfs/end_cow 2/3] fs/xfs/libxfs/xfs_bmap.c:2459:13: warning:
 variable 'tmp_logflags' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202202141243.BLvjvLOP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git xfs/end_cow
head:   20a175b5d3ff8ecb5be2451ce9dcdf82c4aa2afd
commit: 9d499a4f68f24f9dc7880e6f310c7488fe026610 [2/3] xfs: introduce xfs_bmap_update_extent_real()
config: arm-buildonly-randconfig-r001-20220214 (https://download.01.org/0day-ci/archive/20220214/202202141243.BLvjvLOP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=9d499a4f68f24f9dc7880e6f310c7488fe026610
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang xfs/end_cow
        git checkout 9d499a4f68f24f9dc7880e6f310c7488fe026610
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_bmap.c:2459:13: warning: variable 'tmp_logflags' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (!convert) {
                      ^~~~~~~~
   fs/xfs/libxfs/xfs_bmap.c:2464:16: note: uninitialized use occurs here
           *logflagsp |= tmp_logflags;
                         ^~~~~~~~~~~~
   fs/xfs/libxfs/xfs_bmap.c:2459:9: note: remove the 'if' if its condition is always true
           } else if (!convert) {
                  ^~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_bmap.c:1960:20: note: initialize the variable 'tmp_logflags' to silence this warning
           int                     tmp_logflags;   /* partial log flag return val */
                                               ^
                                                = 0
   1 warning generated.


vim +2459 fs/xfs/libxfs/xfs_bmap.c

  1931	
  1932	/*
  1933	 * Update a real allocated extent (including converting an unwritten
  1934	 * allocation to a real allocation or vice versa.)
  1935	 */
  1936	int					/* error */
  1937	xfs_bmap_update_extent_real(
  1938		struct xfs_trans	*tp,
  1939		struct xfs_inode	*ip,	/* incore inode pointer */
  1940		int			whichfork,
  1941		struct xfs_iext_cursor	*icur,
  1942		struct xfs_btree_cur	**curp,	/* if *curp is null, not a btree */
  1943		struct xfs_bmbt_irec	*new,	/* new data to add to file extents */
  1944		int			*logflagsp, /* inode logging flags */
  1945		bool			convert)
  1946	{
  1947		struct xfs_btree_cur	*cur;	/* btree cursor */
  1948		int			error;	/* error return value */
  1949		int			i;	/* temp state */
  1950		struct xfs_ifork	*ifp;	/* inode fork pointer */
  1951		xfs_fileoff_t		del_startoff;	/* start offset of del entry */
  1952		xfs_exntst_t		del_state;
  1953		xfs_fileoff_t		new_endoff;	/* end offset of new entry */
  1954		struct xfs_bmbt_irec	left, right;	/* neighbor extent entries */
  1955		struct xfs_bmbt_irec	prev;		/* previous old extent */
  1956		int			rval=0;	/* return value (logging flags) */
  1957		int			state = xfs_bmap_fork_to_state(whichfork);
  1958		struct xfs_mount	*mp = ip->i_mount;
  1959		struct xfs_bmbt_irec	old;
  1960		int			tmp_logflags;	/* partial log flag return val */
  1961	
  1962		*logflagsp = 0;
  1963	
  1964		cur = *curp;
  1965		ifp = XFS_IFORK_PTR(ip, whichfork);
  1966	
  1967		ASSERT(!isnullstartblock(new->br_startblock));
  1968	
  1969		XFS_STATS_INC(mp, xs_add_exlist);
  1970	
  1971		/*
  1972		 * Set up a bunch of variables to make the tests simpler.
  1973		 */
  1974		error = 0;
  1975		xfs_iext_get_extent(ifp, icur, &prev);
  1976		ASSERT(!convert || new->br_state != prev.br_state);
  1977		new_endoff = new->br_startoff + new->br_blockcount;
  1978		del_startoff = prev.br_startblock +
  1979			new->br_startoff - prev.br_startoff;
  1980		del_state = prev.br_state;
  1981		ASSERT(prev.br_startoff <= new->br_startoff);
  1982		ASSERT(prev.br_startoff + prev.br_blockcount >= new_endoff);
  1983	
  1984		/*
  1985		 * Set flags determining what part of the previous oldext allocation
  1986		 * extent is being replaced by a newext allocation.
  1987		 */
  1988		if (prev.br_startoff == new->br_startoff)
  1989			state |= BMAP_LEFT_FILLING;
  1990		if (prev.br_startoff + prev.br_blockcount == new_endoff)
  1991			state |= BMAP_RIGHT_FILLING;
  1992	
  1993		/*
  1994		 * Check and set flags if this segment has a left neighbor.
  1995		 * Don't set contiguous if the combined extent would be too large.
  1996		 */
  1997		if (xfs_iext_peek_prev_extent(ifp, icur, &left)) {
  1998			state |= BMAP_LEFT_VALID;
  1999			if (isnullstartblock(left.br_startblock))
  2000				state |= BMAP_LEFT_DELAY;
  2001		}
  2002	
  2003		if ((state & BMAP_LEFT_VALID) && !(state & BMAP_LEFT_DELAY) &&
  2004		    left.br_startoff + left.br_blockcount == new->br_startoff &&
  2005		    left.br_startblock + left.br_blockcount == new->br_startblock &&
  2006		    left.br_state == new->br_state &&
  2007		    left.br_blockcount + new->br_blockcount <= MAXEXTLEN)
  2008			state |= BMAP_LEFT_CONTIG;
  2009	
  2010		/*
  2011		 * Check and set flags if this segment has a right neighbor.
  2012		 * Don't set contiguous if the combined extent would be too large.
  2013		 * Also check for all-three-contiguous being too large.
  2014		 */
  2015		if (xfs_iext_peek_next_extent(ifp, icur, &right)) {
  2016			state |= BMAP_RIGHT_VALID;
  2017			if (isnullstartblock(right.br_startblock))
  2018				state |= BMAP_RIGHT_DELAY;
  2019		}
  2020	
  2021		if ((state & BMAP_RIGHT_VALID) && !(state & BMAP_RIGHT_DELAY) &&
  2022		    new_endoff == right.br_startoff &&
  2023		    new->br_startblock + new->br_blockcount == right.br_startblock &&
  2024		    new->br_state == right.br_state &&
  2025		    new->br_blockcount + right.br_blockcount <= MAXEXTLEN &&
  2026		    ((state & (BMAP_LEFT_CONTIG | BMAP_LEFT_FILLING |
  2027			       BMAP_RIGHT_FILLING)) !=
  2028			      (BMAP_LEFT_CONTIG | BMAP_LEFT_FILLING |
  2029			       BMAP_RIGHT_FILLING) ||
  2030		     left.br_blockcount + new->br_blockcount + right.br_blockcount
  2031				<= MAXEXTLEN))
  2032			state |= BMAP_RIGHT_CONTIG;
  2033	
  2034		/*
  2035		 * Switch out based on the FILLING and CONTIG state bits.
  2036		 */
  2037		switch (state & (BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG |
  2038				 BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG)) {
  2039		case BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG |
  2040		     BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
  2041			/*
  2042			 * Setting all of a previous oldext extent to newext.
  2043			 * The left and right neighbors are both contiguous with new.
  2044			 */
  2045			left.br_blockcount += prev.br_blockcount + right.br_blockcount;
  2046	
  2047			xfs_iext_remove(ip, icur, state);
  2048			xfs_iext_remove(ip, icur, state);
  2049			xfs_iext_prev(ifp, icur);
  2050			xfs_iext_update_extent(ip, state, icur, &left);
  2051			ifp->if_nextents -= 2;
  2052			if (cur == NULL) {
  2053				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2054			} else {
  2055				rval = XFS_ILOG_CORE;
  2056				error = xfs_bmbt_lookup_eq(cur, &right, &i);
  2057				if (error)
  2058					goto done;
  2059				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2060					error = -EFSCORRUPTED;
  2061					goto done;
  2062				}
  2063				if ((error = xfs_btree_delete(cur, &i)))
  2064					goto done;
  2065				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2066					error = -EFSCORRUPTED;
  2067					goto done;
  2068				}
  2069				if ((error = xfs_btree_decrement(cur, 0, &i)))
  2070					goto done;
  2071				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2072					error = -EFSCORRUPTED;
  2073					goto done;
  2074				}
  2075				if ((error = xfs_btree_delete(cur, &i)))
  2076					goto done;
  2077				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2078					error = -EFSCORRUPTED;
  2079					goto done;
  2080				}
  2081				if ((error = xfs_btree_decrement(cur, 0, &i)))
  2082					goto done;
  2083				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2084					error = -EFSCORRUPTED;
  2085					goto done;
  2086				}
  2087				error = xfs_bmbt_update(cur, &left);
  2088				if (error)
  2089					goto done;
  2090			}
  2091			break;
  2092	
  2093		case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_LEFT_CONTIG:
  2094			/*
  2095			 * Setting all of a previous oldext extent to newext.
  2096			 * The left neighbor is contiguous, the right is not.
  2097			 */
  2098			left.br_blockcount += prev.br_blockcount;
  2099	
  2100			xfs_iext_remove(ip, icur, state);
  2101			xfs_iext_prev(ifp, icur);
  2102			xfs_iext_update_extent(ip, state, icur, &left);
  2103			ifp->if_nextents--;
  2104			if (cur == NULL) {
  2105				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2106			} else {
  2107				rval = XFS_ILOG_CORE;
  2108				error = xfs_bmbt_lookup_eq(cur, &prev, &i);
  2109				if (error)
  2110					goto done;
  2111				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2112					error = -EFSCORRUPTED;
  2113					goto done;
  2114				}
  2115				if ((error = xfs_btree_delete(cur, &i)))
  2116					goto done;
  2117				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2118					error = -EFSCORRUPTED;
  2119					goto done;
  2120				}
  2121				if ((error = xfs_btree_decrement(cur, 0, &i)))
  2122					goto done;
  2123				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2124					error = -EFSCORRUPTED;
  2125					goto done;
  2126				}
  2127				error = xfs_bmbt_update(cur, &left);
  2128				if (error)
  2129					goto done;
  2130			}
  2131			break;
  2132	
  2133		case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
  2134			/*
  2135			 * Setting all of a previous oldext extent to newext.
  2136			 * The right neighbor is contiguous, the left is not.
  2137			 */
  2138			prev.br_blockcount += right.br_blockcount;
  2139			prev.br_state = new->br_state;
  2140			prev.br_startblock = new->br_startblock;
  2141	
  2142			xfs_iext_next(ifp, icur);
  2143			xfs_iext_remove(ip, icur, state);
  2144			xfs_iext_prev(ifp, icur);
  2145			xfs_iext_update_extent(ip, state, icur, &prev);
  2146			ifp->if_nextents--;
  2147	
  2148			if (cur == NULL) {
  2149				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2150			} else {
  2151				rval = XFS_ILOG_CORE;
  2152				error = xfs_bmbt_lookup_eq(cur, &right, &i);
  2153				if (error)
  2154					goto done;
  2155				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2156					error = -EFSCORRUPTED;
  2157					goto done;
  2158				}
  2159				if ((error = xfs_btree_delete(cur, &i)))
  2160					goto done;
  2161				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2162					error = -EFSCORRUPTED;
  2163					goto done;
  2164				}
  2165				if ((error = xfs_btree_decrement(cur, 0, &i)))
  2166					goto done;
  2167				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2168					error = -EFSCORRUPTED;
  2169					goto done;
  2170				}
  2171				error = xfs_bmbt_update(cur, &prev);
  2172				if (error)
  2173					goto done;
  2174			}
  2175			break;
  2176	
  2177		case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING:
  2178			/*
  2179			 * Setting all of a previous oldext extent to newext.
  2180			 * Neither the left nor right neighbors are contiguous with
  2181			 * the new one.
  2182			 */
  2183			prev.br_startblock = new->br_startblock;
  2184			prev.br_state = new->br_state;
  2185			xfs_iext_update_extent(ip, state, icur, &prev);
  2186	
  2187			if (cur == NULL) {
  2188				rval = XFS_ILOG_DEXT;
  2189			} else {
  2190				rval = 0;
  2191				error = xfs_bmbt_lookup_eq(cur, new, &i);
  2192				if (error)
  2193					goto done;
  2194				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2195					error = -EFSCORRUPTED;
  2196					goto done;
  2197				}
  2198				error = xfs_bmbt_update(cur, &prev);
  2199				if (error)
  2200					goto done;
  2201			}
  2202			break;
  2203	
  2204		case BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG:
  2205			/*
  2206			 * Setting the first part of a previous oldext extent to newext.
  2207			 * The left neighbor is contiguous.
  2208			 */
  2209			left.br_blockcount += new->br_blockcount;
  2210	
  2211			old = prev;
  2212			prev.br_startoff += new->br_blockcount;
  2213			prev.br_startblock += new->br_blockcount;
  2214			prev.br_blockcount -= new->br_blockcount;
  2215	
  2216			xfs_iext_update_extent(ip, state, icur, &prev);
  2217			xfs_iext_prev(ifp, icur);
  2218			xfs_iext_update_extent(ip, state, icur, &left);
  2219	
  2220			if (cur == NULL) {
  2221				rval = XFS_ILOG_DEXT;
  2222			} else {
  2223				rval = 0;
  2224				error = xfs_bmbt_lookup_eq(cur, &old, &i);
  2225				if (error)
  2226					goto done;
  2227				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2228					error = -EFSCORRUPTED;
  2229					goto done;
  2230				}
  2231				error = xfs_bmbt_update(cur, &prev);
  2232				if (error)
  2233					goto done;
  2234				error = xfs_btree_decrement(cur, 0, &i);
  2235				if (error)
  2236					goto done;
  2237				error = xfs_bmbt_update(cur, &left);
  2238				if (error)
  2239					goto done;
  2240			}
  2241			break;
  2242	
  2243		case BMAP_LEFT_FILLING:
  2244			/*
  2245			 * Setting the first part of a previous oldext extent to newext.
  2246			 * The left neighbor is not contiguous.
  2247			 */
  2248			old = prev;
  2249			prev.br_startoff += new->br_blockcount;
  2250			prev.br_startblock += new->br_blockcount;
  2251			prev.br_blockcount -= new->br_blockcount;
  2252	
  2253			xfs_iext_update_extent(ip, state, icur, &prev);
  2254			xfs_iext_insert(ip, icur, new, state);
  2255			ifp->if_nextents++;
  2256	
  2257			if (cur == NULL) {
  2258				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2259			} else {
  2260				rval = XFS_ILOG_CORE;
  2261				error = xfs_bmbt_lookup_eq(cur, &old, &i);
  2262				if (error)
  2263					goto done;
  2264				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2265					error = -EFSCORRUPTED;
  2266					goto done;
  2267				}
  2268				error = xfs_bmbt_update(cur, &prev);
  2269				if (error)
  2270					goto done;
  2271				cur->bc_rec.b = *new;
  2272				if ((error = xfs_btree_insert(cur, &i)))
  2273					goto done;
  2274				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2275					error = -EFSCORRUPTED;
  2276					goto done;
  2277				}
  2278			}
  2279			break;
  2280	
  2281		case BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
  2282			/*
  2283			 * Setting the last part of a previous oldext extent to newext.
  2284			 * The right neighbor is contiguous with the new allocation.
  2285			 */
  2286			old = prev;
  2287			prev.br_blockcount -= new->br_blockcount;
  2288	
  2289			right.br_startoff = new->br_startoff;
  2290			right.br_startblock = new->br_startblock;
  2291			right.br_blockcount += new->br_blockcount;
  2292	
  2293			xfs_iext_update_extent(ip, state, icur, &prev);
  2294			xfs_iext_next(ifp, icur);
  2295			xfs_iext_update_extent(ip, state, icur, &right);
  2296	
  2297			if (cur == NULL) {
  2298				rval = XFS_ILOG_DEXT;
  2299			} else {
  2300				rval = 0;
  2301				error = xfs_bmbt_lookup_eq(cur, &old, &i);
  2302				if (error)
  2303					goto done;
  2304				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2305					error = -EFSCORRUPTED;
  2306					goto done;
  2307				}
  2308				error = xfs_bmbt_update(cur, &prev);
  2309				if (error)
  2310					goto done;
  2311				error = xfs_btree_increment(cur, 0, &i);
  2312				if (error)
  2313					goto done;
  2314				error = xfs_bmbt_update(cur, &right);
  2315				if (error)
  2316					goto done;
  2317			}
  2318			break;
  2319	
  2320		case BMAP_RIGHT_FILLING:
  2321			/*
  2322			 * Setting the last part of a previous oldext extent to newext.
  2323			 * The right neighbor is not contiguous.
  2324			 */
  2325			old = prev;
  2326			prev.br_blockcount -= new->br_blockcount;
  2327	
  2328			xfs_iext_update_extent(ip, state, icur, &prev);
  2329			xfs_iext_next(ifp, icur);
  2330			xfs_iext_insert(ip, icur, new, state);
  2331			ifp->if_nextents++;
  2332	
  2333			if (cur == NULL) {
  2334				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2335			} else {
  2336				rval = XFS_ILOG_CORE;
  2337				error = xfs_bmbt_lookup_eq(cur, &old, &i);
  2338				if (error)
  2339					goto done;
  2340				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2341					error = -EFSCORRUPTED;
  2342					goto done;
  2343				}
  2344				error = xfs_bmbt_update(cur, &prev);
  2345				if (error)
  2346					goto done;
  2347				error = xfs_bmbt_lookup_eq(cur, new, &i);
  2348				if (error)
  2349					goto done;
  2350				if (XFS_IS_CORRUPT(mp, i != 0)) {
  2351					error = -EFSCORRUPTED;
  2352					goto done;
  2353				}
  2354				if ((error = xfs_btree_insert(cur, &i)))
  2355					goto done;
  2356				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2357					error = -EFSCORRUPTED;
  2358					goto done;
  2359				}
  2360			}
  2361			break;
  2362	
  2363		case 0:
  2364			/*
  2365			 * Setting the middle part of a previous oldext extent to
  2366			 * newext.  Contiguity is impossible here.
  2367			 * One extent becomes three extents.
  2368			 */
  2369			old = prev;
  2370			prev.br_blockcount = new->br_startoff - prev.br_startoff;
  2371	
  2372			right.br_startoff = new_endoff;
  2373			right.br_blockcount =
  2374				old.br_startoff + old.br_blockcount - new_endoff;
  2375			right.br_startblock = old.br_startblock + prev.br_blockcount +
  2376				new->br_blockcount;
  2377			right.br_state = prev.br_state;
  2378	
  2379			xfs_iext_update_extent(ip, state, icur, &prev);
  2380			xfs_iext_next(ifp, icur);
  2381			xfs_iext_insert(ip, icur, &right, state);
  2382			xfs_iext_insert(ip, icur, new, state);
  2383			ifp->if_nextents += 2;
  2384	
  2385			if (cur == NULL) {
  2386				rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
  2387			} else {
  2388				rval = XFS_ILOG_CORE;
  2389				error = xfs_bmbt_lookup_eq(cur, &old, &i);
  2390				if (error)
  2391					goto done;
  2392				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2393					error = -EFSCORRUPTED;
  2394					goto done;
  2395				}
  2396				/* new right extent - oldext */
  2397				error = xfs_bmbt_update(cur, &right);
  2398				if (error)
  2399					goto done;
  2400				/* new left extent - oldext */
  2401				cur->bc_rec.b = prev;
  2402				if ((error = xfs_btree_insert(cur, &i)))
  2403					goto done;
  2404				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2405					error = -EFSCORRUPTED;
  2406					goto done;
  2407				}
  2408				/*
  2409				 * Reset the cursor to the position of the new extent
  2410				 * we are about to insert as we can't trust it after
  2411				 * the previous insert.
  2412				 */
  2413				error = xfs_bmbt_lookup_eq(cur, new, &i);
  2414				if (error)
  2415					goto done;
  2416				if (XFS_IS_CORRUPT(mp, i != 0)) {
  2417					error = -EFSCORRUPTED;
  2418					goto done;
  2419				}
  2420				/* new middle extent - newext */
  2421				if ((error = xfs_btree_insert(cur, &i)))
  2422					goto done;
  2423				if (XFS_IS_CORRUPT(mp, i != 1)) {
  2424					error = -EFSCORRUPTED;
  2425					goto done;
  2426				}
  2427			}
  2428			break;
  2429	
  2430		case BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG | BMAP_RIGHT_CONTIG:
  2431		case BMAP_RIGHT_FILLING | BMAP_LEFT_CONTIG | BMAP_RIGHT_CONTIG:
  2432		case BMAP_LEFT_FILLING | BMAP_RIGHT_CONTIG:
  2433		case BMAP_RIGHT_FILLING | BMAP_LEFT_CONTIG:
  2434		case BMAP_LEFT_CONTIG | BMAP_RIGHT_CONTIG:
  2435		case BMAP_LEFT_CONTIG:
  2436		case BMAP_RIGHT_CONTIG:
  2437			/*
  2438			 * These cases are all impossible.
  2439			 */
  2440			ASSERT(0);
  2441		}
  2442	
  2443		/* update reverse mappings */
  2444		if (!convert) {
  2445			old = *new;
  2446			old.br_startblock = del_startoff;
  2447			old.br_state = del_state;
  2448			xfs_rmap_unmap_extent(tp, ip, whichfork, &old);
  2449			xfs_rmap_map_extent(tp, ip, whichfork, new);
  2450		} else {
  2451			xfs_rmap_convert_extent(mp, tp, ip, whichfork, new);
  2452		}
  2453	
  2454		/* convert to a btree or extents if necessary */
  2455		if (xfs_bmap_needs_btree(ip, whichfork)) {
  2456			ASSERT(cur == NULL);
  2457			error = xfs_bmap_extents_to_btree(tp, ip, &cur, 0,
  2458					&tmp_logflags, whichfork);
> 2459		} else if (!convert) {
  2460			error = xfs_bmap_btree_to_extents(tp, ip, cur,
  2461					&tmp_logflags, whichfork);
  2462		}
  2463	
  2464		*logflagsp |= tmp_logflags;
  2465		if (error)
  2466			goto done;
  2467	
  2468		/* clear out the allocated field, done with it now in any case. */
  2469		if (cur) {
  2470			cur->bc_ino.allocated = 0;
  2471			*curp = cur;
  2472		}
  2473	
  2474		xfs_bmap_check_leaf_extents(*curp, ip, whichfork);
  2475	done:
  2476		*logflagsp |= rval;
  2477		return error;
  2478	}
  2479	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
